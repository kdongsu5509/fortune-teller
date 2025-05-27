package com.jangpyeong.fortuneteller.domain.analyze.api.dto.req;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import java.time.LocalDateTime;

public record SajuReqDto(
        @NotNull String name,
        @PastOrPresent LocalDateTime birthDate,
        @NotNull BirthTime time,
        @NotNull String sex
) {
}
