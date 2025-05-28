package com.jangpyeong.fortuneteller.infra.analyze;

import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.time.Duration;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

@RequiredArgsConstructor
@Repository
public class ResultCacheRepositoryImpl implements ResultCacheRepository {

    private final RedisTemplate<String, ResultCacheDto> redisTemplate;
    private static final Duration TTL = Duration.ofMinutes(45);
    private static final String PREFIX = "user:";

    @Override
    public ResultCacheDto get(String email, ResultType type) {
        HashOperations<String, String, ResultCacheDto> hashOps = redisTemplate.opsForHash();
        return hashOps.get(makeKey(email, type), type.name());
    }

    @Override
    public Map<String, ResultCacheDto> getAll(String email, ResultType type) {
        HashOperations<String, String, ResultCacheDto> hashOps = redisTemplate.opsForHash();
        return hashOps.entries(makeKey(email, type));
    }

    @Override
    public void set(String email, ResultType type, ResultCacheDto dto) {
        HashOperations<String, String, ResultCacheDto> hashOps = redisTemplate.opsForHash();
        String key = makeKey(email, type);
        hashOps.put(key, type.name(), dto);
        redisTemplate.expire(key, TTL); // 키 단위 TTL 설정
    }

    @Override
    public void delete(String email, ResultType type) {
        redisTemplate.opsForHash().delete(makeKey(email, type), type.name());
    }

    private String makeKey(String email, ResultType type) {
        return PREFIX + email + type.name() + ":chat-result";
    }
}