package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

import java.util.List;
import java.util.Map;

public record TodayRespDto(
        String summary,
        List<String> keywords,
        String luckyColor,
        int luckyNumber,
        String luckyDirection,
        Map<String, Category> categories,
        String advice
) {
    public record Category(
            String description
    ) {
    }
}

