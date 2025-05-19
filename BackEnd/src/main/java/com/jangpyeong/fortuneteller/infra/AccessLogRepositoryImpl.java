package com.jangpyeong.fortuneteller.infra;

import com.jangpyeong.fortuneteller.v1.fortune.access.domain.AccessLog;
import com.jangpyeong.fortuneteller.v1.fortune.access.domain.AccessLogRepository;
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
