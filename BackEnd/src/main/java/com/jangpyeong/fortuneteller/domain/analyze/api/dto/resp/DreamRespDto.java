package com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp;

import java.util.List;

public record DreamRespDto(
        String summary,
        String dreamType,
        List<SymbolMeaning> symbolMeanings,
        String advice
) {
    public record SymbolMeaning(
            String symbol,
            String meaning
    ) {
    }
}
