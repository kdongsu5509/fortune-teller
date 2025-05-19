package com.jangpyeong.fortuneteller.domain.analyze.dao;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@Schema(
        description = "AnalyzeResultDTO",
        title = "AnalyzeResultDTO",
        example = """
                {
                    "result": "result",
                }
                """
)
public class AnalyzeResultDTO {
    private String result;
}
