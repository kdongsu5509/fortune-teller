package com.jangpyeong.fortuneteller.infra.access;

import com.jangpyeong.fortuneteller.domain.access.AccessLog;
import com.jangpyeong.fortuneteller.domain.access.AccessLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class AccessLogRepositoryImpl implements AccessLogRepository {

    private final AccessLogJpaRepository accessLogJpaRepository;

    @Override
    public void save(AccessLog accessLog) {
        accessLogJpaRepository.save(accessLog);
    }
}
