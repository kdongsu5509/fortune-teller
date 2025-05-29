package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.domain.Result;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultRepository;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ResultWriteServiceImpl implements ResultWriteService {

    private final ResultRepository resultRepository;

    @Override
    @Transactional
    public void save(String userEmail, ResultType type, String content) {
        Result result = Result.create(
                userEmail,
                type,
                content
        );
        resultRepository.save(result);
    }
}