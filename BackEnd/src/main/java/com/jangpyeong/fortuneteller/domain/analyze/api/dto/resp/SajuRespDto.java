package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

public record SajuRespDto(
        String summary,
        String ohaeng,
        String personality,
        String luck,
        String suggestion
) {
}
