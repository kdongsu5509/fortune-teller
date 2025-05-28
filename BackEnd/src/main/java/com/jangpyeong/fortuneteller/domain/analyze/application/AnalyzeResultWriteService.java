package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;

public interface AnalyzeResultWriteService {
    void save(String userEmail, ResultType type, String content);
}
