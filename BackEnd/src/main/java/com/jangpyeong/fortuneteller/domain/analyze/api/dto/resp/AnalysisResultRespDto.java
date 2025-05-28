package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

import com.jangpyeong.fortuneteller.domain.analyze.domain.Result;
import java.util.List;
import org.springframework.data.domain.Page;

public record AnalysisResultRespDto(
        List<SummarizedResultDto> content,
        int page,
        int size,
        long totalElements,
        int totalPages
) {
    public static AnalysisResultRespDto from(Page<Result> page) {
        List<SummarizedResultDto> summaries = page.getContent().stream()
                .map(SummarizedResultDto::from)
                .toList();

        return new AnalysisResultRespDto(
                summaries,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages()
        );
    }
}
