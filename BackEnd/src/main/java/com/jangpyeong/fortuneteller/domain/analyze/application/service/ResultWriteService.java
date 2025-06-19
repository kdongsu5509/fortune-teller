package com.jangpyeong.fortuneteller.domain.analyze.application.service;

import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;

public interface ResultWriteService {
    void save(String userEmail, ResultType type, String content);
}
