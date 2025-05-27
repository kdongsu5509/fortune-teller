package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.DreamRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.FaceRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.SajuRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.TodayRespDto;
import org.springframework.stereotype.Component;

@Component
public class PromptFormatRegistry {

    public <T> String getFormatFor(Class<T> clazz) {
        if (clazz == SajuRespDto.class) {
            return """
                        {
                          \"ohaeng\": \"...\",
                          \"personality\": \"...\",
                          \"luck\": \"...\",
                          \"suggestion\": \"...\"
                        }
                    """;
        } else if (clazz == FaceRespDto.class) {
            return """
                        {
                          \"summary\": \"...\",
                          \"keywords\": [...],
                          \"features\": { ... },
                          \"advice\": \"...\"
                        }
                    """;
        } else if (clazz == DreamRespDto.class) {
            return """
                        {
                          \"summary\": \"...\",
                          \"dream_type\": \"...\",
                          \"symbol_meanings\": [{\"symbol\": \"...\", \"meaning\": \"...\"}],
                          \"advice\": \"...\"
                        }
                    """;
        } else if (clazz == TodayRespDto.class) {
            return """
                        {
                          \"summary\": \"...\",
                          \"keywords\": [...],
                          \"lucky_color\": \"...\",
                          \"lucky_number\": 0,
                          \"lucky_direction\": \"...\",
                          \"categories\": {
                            \"general\": {\"description\": \"...\"},
                            \"money\": {\"description\": \"...\"},
                            \"love\": {\"description\": \"...\"},
                            \"health\": {\"description\": \"...\"}
                          },
                          \"advice\": \"...\"
                        }
                    """;
        }
        return "{}";
    }
}
