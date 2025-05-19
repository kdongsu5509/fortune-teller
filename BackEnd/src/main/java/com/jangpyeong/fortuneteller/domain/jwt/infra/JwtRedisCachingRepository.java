package com.jangpyeong.fortuneteller.domain.jwt.infra;

import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtAuthRedis;
import java.util.Optional;
import org.springframework.data.repository.CrudRepository;

public interface JwtRedisCachingRepository extends CrudRepository<JwtAuthRedis, String> {
    Optional<JwtAuthRedis> findJwtAuthRedisByAccessToken(String accessToken);

    Optional<JwtAuthRedis> findJwtAuthRedisByRefreshToken(String refreshToken);

    Optional<JwtAuthRedis> findJwtAuthRedisByEmail(String email);

    void removeJwtAuthRedisById(String id);

    void removeJwtAuthRedisByAccessToken(String accessToken);

    void removeJwtAuthRedisByRefreshToken(String refreshToken);
}
