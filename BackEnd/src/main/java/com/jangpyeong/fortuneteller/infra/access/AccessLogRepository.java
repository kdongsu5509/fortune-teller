package com.jangpyeong.fortuneteller.infra.access;

import com.jangpyeong.fortuneteller.v1.fortune.access.domain.AccessLog;

public interface AccessLogRepository {
    void save(AccessLog accessLog);
}
