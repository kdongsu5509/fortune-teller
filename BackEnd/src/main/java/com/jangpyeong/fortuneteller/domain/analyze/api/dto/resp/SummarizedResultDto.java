package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

import com.jangpyeong.fortuneteller.domain.analyze.domain.Result;
import java.time.LocalDateTime;
import java.util.UUID;

public record SummarizedResultDto(
        UUID resultId,
        String analysisContent,
        LocalDateTime createdAt
) {
    public static SummarizedResultDto from(Result entity) {
        return new SummarizedResultDto(
                entity.getId(),
                entity.getContents(),
                entity.getCreatedAt()
        );
    }
}
