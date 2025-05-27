package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

public record SajuRespDto(
        String ohaeng,
        String personality,
        String luck,
        String suggestion
) {
}
