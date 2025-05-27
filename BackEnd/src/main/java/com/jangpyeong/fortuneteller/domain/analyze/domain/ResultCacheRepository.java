package com.jangpyeong.fortuneteller.domain.analyze.domain;

import java.time.Duration;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

@RequiredArgsConstructor
@Repository
public class ResultCacheRepository {

    private final RedisTemplate<String, ResultCacheDto> redisTemplate;
    private static final Duration TTL = Duration.ofMinutes(30);

    public ResultCacheDto get(String email, ResultType type) {
        return redisTemplate.opsForValue().get(makeKey(email, type));
    }

    public void set(String email, ResultType type, ResultCacheDto dto) {
        redisTemplate.opsForValue().set(makeKey(email, type), dto, TTL);
    }
    
    public void delete(String email, ResultType type) {
        redisTemplate.delete(makeKey(email, type));
    }

    private String makeKey(String email, ResultType type) {
        return "user:" + email + ":result:" + type.name();
    }
}
