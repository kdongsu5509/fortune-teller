package com.jangpyeong.fortuneteller.infra.access_log;


public interface AccessLogRepository {
    void save(AccessLog accessLog);
}
