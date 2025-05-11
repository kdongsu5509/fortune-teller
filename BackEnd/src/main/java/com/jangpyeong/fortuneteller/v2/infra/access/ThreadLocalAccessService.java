package com.jangpyeong.fortuneteller.v2.infra.access;

import com.jangpyeong.fortuneteller.v2.filter.access.AccessLogRequest;
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
