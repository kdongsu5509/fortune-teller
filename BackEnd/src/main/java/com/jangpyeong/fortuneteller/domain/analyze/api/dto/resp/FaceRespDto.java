package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

import java.util.List;
import java.util.Map;

public record FaceRespDto(
        String summary,
        List<String> keywords,
        Map<String, Feature> features,
        String advice
) {
    public record Feature(
            String description
    ) {
    }
}