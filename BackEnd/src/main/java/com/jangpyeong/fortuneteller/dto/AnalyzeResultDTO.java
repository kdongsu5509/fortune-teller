package com.jangpyeong.fortuneteller.dto;

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
                    "uuid": "uuid"
                }
                """
)
public class AnalyzeResultDTO {
    private String result;
    private String uuid;
}
