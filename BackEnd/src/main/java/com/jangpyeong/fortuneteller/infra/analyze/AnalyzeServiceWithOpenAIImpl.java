package com.jangpyeong.fortuneteller.infra.analyze;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.DreamReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.SajuReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.DreamRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.FaceRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.SajuRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.TodayRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.application.AnalyzeService;
import com.jangpyeong.fortuneteller.domain.analyze.application.AsyncAnalyzeResultStoreService;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnalyzeServiceWithOpenAIImpl implements AnalyzeService {

    private final AiAnalysisExecutor executor;
    private final AsyncAnalyzeResultStoreService asyncAnalyzeResultStoreService;

    @Override
    public SajuRespDto doAnalyzeSaju(SajuReqDto req, String email) {
        return analyzeAndStore("saju", Map.of(
                "name", req.name(),
                "birthDate", req.birthDate().toString(),
                "birthTime", req.time().getLabel(),
                "sex", req.sex()
        ), SajuRespDto.class, email, ResultType.SAJU);
    }

    @Override
    public DreamRespDto doAnalyzeDream(DreamReqDto req, String email) {
        return analyzeAndStore("dream", Map.of(
                "dream", req.dreamExplanation()
        ), DreamRespDto.class, email, ResultType.DREAM);
    }

    @Override
    public FaceRespDto doAnalyzeFace(String imageUrl, String email) {
        return analyzeAndStore("face", Map.of(
                "imageUrl", imageUrl
        ), FaceRespDto.class, email, ResultType.FACE);
    }

    @Override
    public TodayRespDto doAnalyzeTodayLuck(String today, SajuReqDto req, String email) {
        return analyzeAndStore("today-luck", Map.of(
                "today", today,
                "name", req.name(),
                "birthDate", req.birthDate().toString(),
                "birthTime", req.time().getLabel(),
                "sex", req.sex()
        ), TodayRespDto.class, email, ResultType.TODAY_LUCK);
    }

    private <T> T analyzeAndStore(
            String type,
            Map<String, Object> variables,
            Class<T> responseType,
            String userEmail,
            ResultType resultType
    ) {
        T result = executor.analyze(type, variables, responseType);
        String summary = extractSummary(result);
        asyncAnalyzeResultStoreService.store(userEmail, resultType, summary);
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

