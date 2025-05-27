package com.jangpyeong.fortuneteller.domain.analyze.api.dto.req;

import jakarta.validation.constraints.NotNull;

public record FaceReqDto(
        @NotNull String imageUrl
) {
}
