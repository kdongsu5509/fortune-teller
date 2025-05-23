package com.jangpyeong.fortuneteller.infra.access_log;

import com.jangpyeong.fortuneteller.common.filter.AccessLogRequest;
import org.springframework.stereotype.Service;

@Service
public class ThreadLocalAccessService {
    private final ThreadLocal<AccessLogRequest> threadLocal = new ThreadLocal<>();

    public void putAccessLog(AccessLogRequest accessLogRequest) {
        this.threadLocal.set(accessLogRequest);
    }

    public AccessLogRequest getAccessLog() {
        return this.threadLocal.get();
    }

    public void removeThreadLocal() {
        this.threadLocal.remove();
    }
}
