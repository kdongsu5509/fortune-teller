package com.jangpyeong.fortuneteller.domain.chat.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jangpyeong.fortuneteller.domain.chat.domain.ChatMessage;
import com.jangpyeong.fortuneteller.domain.chat.domain.ChatRedisMessage;
import com.jangpyeong.fortuneteller.infra.chat.ChatMessageJpaRepository;
import com.jangpyeong.fortuneteller.infra.jwt.JwtUtil;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicLong;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ChatCacheServiceImpl implements ChatCacheService {

    private final JwtUtil jwtUtil;
    private final ChatMessageJpaRepository jpaRepository;
    private final RedisTemplate<String, ChatRedisMessage> redisTemplate;
    private static final Duration CHAT_TTL = Duration.ofHours(2);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private static final String REDIS_KEY_PREFIX = "chat:";

    private final AtomicLong messageIdGenerator = new AtomicLong();

    @Override
    @Transactional
    public void appendMessage(Long sessionId, ChatRedisMessage message, String jwt, String chatRole) {
        // Redis Hash 저장
        long messageId = messageIdGenerator.incrementAndGet();
        String redisKey = REDIS_KEY_PREFIX + sessionId + ":" + messageId;

        Map<String, String> fields = Map.of("role", message.role(), "content", message.content(), "timestamp",
                message.timestamp());

        redisTemplate.opsForHash().putAll(redisKey, fields);
        redisTemplate.expire(redisKey, CHAT_TTL);

        // 사용자 인증
        String email = jwtUtil.getUsername(jwt);
        // JPA 저장
        ChatMessage entity = new ChatMessage(sessionId, email, chatRole, message.content());
        jpaRepository.save(entity);
    }

    @Override
    public List<ChatRedisMessage> getMessages(Long sessionId) {
        String redisPattern = REDIS_KEY_PREFIX + sessionId + ":*";
        Set<String> keys = redisTemplate.keys(redisPattern);
        if (keys == null || keys.isEmpty()) {
            getMessagesFromJpa(sessionId);
        }

        return keys.stream().sorted().map(key -> {
            Map<Object, Object> hash = redisTemplate.opsForHash().entries(key);
            return new ChatRedisMessage(hash.get("role").toString(), hash.get("content").toString(),
                    hash.get("timestamp").toString());
        }).toList();
    }

    @Override
    @Transactional
    public void clearHistory(String sessionId) {
        String redisPattern = REDIS_KEY_PREFIX + sessionId + ":*";
        Set<String> keys = redisTemplate.keys(redisPattern);
        if (keys != null && !keys.isEmpty()) {
            redisTemplate.delete(keys);
        }
    }

    public List<ChatRedisMessage> getMessagesFromJpa(Long sessionId) {
        return jpaRepository.findBySessionIdOrderByCreatedAt(sessionId).stream()
                .map(e -> new ChatRedisMessage(e.getContentRole(), e.getContent(), e.getCreatedAt().toString()))
                .toList();
    }
}
