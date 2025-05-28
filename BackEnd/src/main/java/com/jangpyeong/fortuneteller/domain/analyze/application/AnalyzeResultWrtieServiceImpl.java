package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AnalyzeResultWrtieServiceImpl implements AnalyzeResultWriteService {
    @Override
    @Transactional
    public void save(String userEmail, ResultType type, String content) {
        //TODO: DB에 저장하는 로직을 구현해야합니다.
    }
}
