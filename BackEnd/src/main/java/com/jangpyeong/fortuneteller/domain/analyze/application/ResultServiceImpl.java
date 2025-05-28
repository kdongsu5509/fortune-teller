package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.AnalysisResultRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.domain.Result;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultRepository;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ResultServiceImpl implements ResultService {

    private final ResultAsyncStoreService resultAsyncStoreService;
    private final ResultRepository resultRepository;

    @Override
    public void store(String userEmail, ResultType resultType, String summary) {
        resultAsyncStoreService.store(userEmail, resultType, summary);
    }

    @Override
    public void delete(UUID id) {
        resultRepository.deleteById(id);
    }

    @Override
    public String getSingleAnalysis(UUID id) {
        Result result = resultRepository.findById(id)
                .orElseThrow(
                        FailToGetAnalysis::new
                );
        return result.getContents();
    }

    @Override
    public AnalysisResultRespDto getSomeFaceAnalysis(String userEmail, int page, int size) {
        ResultType resultType = ResultType.FACE;
        return AnalysisResultRespDto.from(
                getResultPage(userEmail, page, size, resultType)
        );
    }

    @Override
    public AnalysisResultRespDto getSomeSajuAnalysis(String userEmail, int page, int size) {
        ResultType resultType = ResultType.SAJU;
        return AnalysisResultRespDto.from(
                getResultPage(userEmail, page, size, resultType)
        );
    }

    @Override
    public AnalysisResultRespDto getSomeDreamAnalysis(String userEmail, int page, int size) {
        ResultType resultType = ResultType.DREAM;
        return AnalysisResultRespDto.from(
                getResultPage(userEmail, page, size, resultType)
        );
    }

    @Override
    public AnalysisResultRespDto getSomeTodayLuckAnalysis(String userEmail, int page, int size) {
        ResultType resultType = ResultType.TODAY_LUCK;
        return AnalysisResultRespDto.from(
                getResultPage(userEmail, page, size, resultType)
        );
    }

    private Page<Result> getResultPage(String userEmail, int page, int size, ResultType resultType) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        return resultRepository.findByUserEmailAndResultType(userEmail, resultType, pageable);
    }

    private static class FailToGetAnalysis extends RuntimeException {
    }
}
