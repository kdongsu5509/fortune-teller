package com.jangpyeong.fortuneteller.domain.jwt;

import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtAuthRedis;
import java.util.List;
import java.util.Optional;

public interface JwtRepository {

    Optional<JwtAuthRedis> findJwtAuthRedisByAccessToken(
            String accessToken);

    Optional<JwtAuthRedis> findJwtAuthRedisByRefreshToken(
            String refreshToken);

    JwtAuthRedis saveOrUpdateJwtAuth(
            JwtAuthRedis jwtAuthRedis);

    List<JwtAuthRedis> findAllJwtAuthRedis();

    Optional<JwtAuthRedis> findJwtAuthRedisByEmail(String email);

    void removeJwtAuthRedisById(String id);

    void removeJwtAuthRedisByRefreshToken(String refreshToken);

    void removeJwtAuthRedisByAccessToken(String accessToken);
}
