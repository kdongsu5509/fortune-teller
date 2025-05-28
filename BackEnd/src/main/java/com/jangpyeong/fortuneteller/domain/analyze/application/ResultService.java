package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.AnalysisResultRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.util.UUID;

public interface ResultService {

    void store(String userEmail, ResultType resultType, String summary);

    void delete(UUID id);

    String getSingleAnalysis(UUID id);

    AnalysisResultRespDto getSomeFaceAnalysis(String userEmail, int page, int size);

    AnalysisResultRespDto getSomeSajuAnalysis(String userEmail, int page, int size);

    AnalysisResultRespDto getSomeDreamAnalysis(String userEmail, int page, int size);

    AnalysisResultRespDto getSomeTodayLuckAnalysis(String userEmail, int page, int size);
}
