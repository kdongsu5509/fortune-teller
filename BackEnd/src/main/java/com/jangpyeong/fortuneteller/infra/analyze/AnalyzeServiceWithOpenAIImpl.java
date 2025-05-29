package com.jangpyeong.fortuneteller.infra.analyze;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.DreamReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.SajuReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.DreamRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.FaceRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.SajuRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.TodayRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.application.AnalyzeService;
import com.jangpyeong.fortuneteller.domain.analyze.application.ResultService;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AnalyzeServiceWithOpenAIImpl implements AnalyzeService {

    private final AiAnalysisExecutor executor;
    private final ResultService resultService;

    @Override
    public SajuRespDto doAnalyzeSaju(SajuReqDto req, String email) {
        Map<String, Object> variables = new HashMap<>();
        variables.put("name", req.name());
        variables.put("birthDate", req.birthDate().toString());
        variables.put("birthTime", req.time().getLabel());
        variables.put("sex", req.sex());
        return analyzeAndStore("saju", variables, SajuRespDto.class, email, ResultType.SAJU);
    }

    @Override
    public DreamRespDto doAnalyzeDream(DreamReqDto req, String email) {
        Map<String, Object> variables = new HashMap<>();
        variables.put("dream", req.dreamExplanation());
        return analyzeAndStore("dream", variables, DreamRespDto.class, email, ResultType.DREAM);
    }

    @Override
    public FaceRespDto doAnalyzeFace(String imageUrl, String email) {
        Map<String, Object> variables = new HashMap<>();
        variables.put("imageUrl", imageUrl);
        return analyzeAndStore("face", variables, FaceRespDto.class, email, ResultType.FACE);
    }

    @Override
    public TodayRespDto doAnalyzeTodayLuck(String today, SajuReqDto req, String email) {
        Map<String, Object> variables = new HashMap<>();
        variables.put("today", today);
        variables.put("name", req.name());
        variables.put("birthDate", req.birthDate().toString());
        variables.put("birthTime", req.time().getLabel());
        variables.put("sex", req.sex());
        return analyzeAndStore("today-luck", variables, TodayRespDto.class, email, ResultType.TODAY_LUCK);
    }


    private <T> T analyzeAndStore(
            String type,
            Map<String, Object> variables,
            Class<T> responseType,
            String userEmail,
            ResultType resultType
    ) {
        T result = executor.analyze(type, variables, responseType, resultType);
        String summary = extractSummary(result);
        resultService.store(userEmail, resultType, summary);
        return result;
    }

    private <T> String extractSummary(T result) {
        try {
            return (String) result.getClass().getMethod("summary").invoke(result);
        } catch (Exception e) {
            throw new IllegalStateException("응답 객체에서 summary() 호출 실패", e);
        }
    }

}

