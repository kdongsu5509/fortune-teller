package com.jangpyeong.fortuneteller.common.config;

import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtAuthRedis;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * Redis 설정 클래스
 * <p>
 * RedisTemplate을 사용하여 Redis에 객체를 저장하고 조회할 수 있도록 설정합니다.
 */

@Configuration
public class RedisConfig {
    @Bean
    public RedisTemplate<String, JwtAuthRedis> jwtRedisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, JwtAuthRedis> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(new GenericJackson2JsonRedisSerializer());
        return template;
    }
}
