package com.jangpyeong.fortuneteller.infra.analyze;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jangpyeong.fortuneteller.domain.llm.PromptFormatRegistry;
import com.jangpyeong.fortuneteller.domain.llm.application.AiPromptService;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AiAnalysisExecutor {

    private final ObjectMapper objectMapper;
    private final PromptFormatRegistry promptFormatRegistry;
    private final AiPromptService aiPromptService;

    public <T> T analyze(String type, Map<String, Object> variables, Class<T> responseType) {
        variables.put("format", promptFormatRegistry.getFormatFor(responseType));
        PromptTemplate template = new PromptTemplate(getPromptTemplateResource(type));
        Prompt prompt = template.create(variables);
        Generation generation = aiPromptService.sendPrompt(prompt);
        return parseLLMResponseToResponseDto(generation.getOutput().getText(), responseType);
    }

    private Resource getPromptTemplateResource(String type) {
        return switch (type) {
            case "saju" -> new ClassPathResource("prompt/saju.txt");
            case "dream" -> new ClassPathResource("prompt/dream.txt");
            case "today-luck" -> new ClassPathResource("prompt/today.txt");
            case "face" -> new ClassPathResource("prompt/face.txt");
            default -> throw new IllegalArgumentException("지원하지 않는 분석 타입입니다: " + type);
        };
    }

    private <T> T parseLLMResponseToResponseDto(String response, Class<T> clazz) {
        try {
            return objectMapper.readValue(response, clazz);
        } catch (Exception e) {
            throw new LlmResponseParsingException();
        }
    }

    private static class LlmResponseParsingException extends RuntimeException {
    }
}
