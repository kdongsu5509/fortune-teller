package com.jangpyeong.fortuneteller.v2.infra.jwt;

import com.jangpyeong.fortuneteller.v2.domain.jwt.JwtRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import static com.jangpyeong.fortuneteller.v2.supprot.util.CommUtils.EXPIRED_JWT_CLEANUP_CRON;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtRefreshCleaner {

    private final JwtRepository jwtRepository;

    @Scheduled(cron = EXPIRED_JWT_CLEANUP_CRON)
    public void cleanExpiredJwts() {
        LocalDateTime now = LocalDateTime.now();
        log.info(" 만료된 refresh 토큰 정리 시작: {}", now);

        jwtRepository.findAllJwtAuthRedis().forEach(jwt -> {
            if(jwt.getRefreshExpiration() != null && jwt.getRefreshExpiration().isBefore(now)) {
                log.info("삭제 대상: {}", jwt.getEmail());
                jwtRepository.removeJwtAuthRedisById(jwt.getId());
            }
        });

        log.info("만료된 refresh 토큰 정리 완료");
    }

}
