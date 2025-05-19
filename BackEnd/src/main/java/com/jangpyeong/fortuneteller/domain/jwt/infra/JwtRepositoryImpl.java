package com.jangpyeong.fortuneteller.domain.jwt.infra;

import com.jangpyeong.fortuneteller.common.util.JsonUtils;
import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtAuthRedis;
import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtRepository;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
@Slf4j
public class JwtRepositoryImpl implements JwtRepository {

    private final JwtRedisCachingRepository jwtRedisCachingRepository;

    @Override
    public Optional<JwtAuthRedis> findJwtAuthRedisByEmail(String email) {
        return jwtRedisCachingRepository.findJwtAuthRedisByEmail(email);
    }

    @Override
    public Optional<JwtAuthRedis> findJwtAuthRedisByAccessToken(String accessToken) {
        return jwtRedisCachingRepository.findJwtAuthRedisByAccessToken(accessToken);
    }

    @Override
    public Optional<JwtAuthRedis> findJwtAuthRedisByRefreshToken(String refreshToken) {
        return jwtRedisCachingRepository.findJwtAuthRedisByRefreshToken(refreshToken);
    }

    @Override
    public JwtAuthRedis saveOrUpdateJwtAuth(JwtAuthRedis jwtAuthRedis) {
        JwtAuthRedis saved = jwtRedisCachingRepository.save(jwtAuthRedis);

        log.info("Saved JWT entity with UUID key: {}", JsonUtils.toJson(saved));
        return saved;
    }

    @Override
    public List<JwtAuthRedis> findAllJwtAuthRedis() {
        Iterable<JwtAuthRedis> iterable = jwtRedisCachingRepository.findAll();
        return StreamSupport.stream(iterable.spliterator(), false)
                .collect(Collectors.toList());
    }

    @Override
    public void removeJwtAuthRedisById(String id) {
        jwtRedisCachingRepository.removeJwtAuthRedisById(id);
    }

    @Override
    public void removeJwtAuthRedisByRefreshToken(String refreshToken) {
        jwtRedisCachingRepository.removeJwtAuthRedisByRefreshToken(refreshToken);
    }

    @Override
    public void removeJwtAuthRedisByAccessToken(String accessToken) {
        jwtRedisCachingRepository.removeJwtAuthRedisByAccessToken(accessToken);
    }
}
