package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class AsyncAnalyzeResultStoreService {
    private final AnalyzeResultWriteService writeService;

    @Async
    public void store(String userEmail, ResultType type, String contents) {
        writeService.save(userEmail, type, contents);
    }
}
