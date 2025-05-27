package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.DreamReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.SajuReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.DreamRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.FaceRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.SajuRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.TodayRespDto;
import com.jangpyeong.fortuneteller.domain.chat.application.ChatService;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnalyzeServiceWithOpenAIImpl implements AnalyzeService {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final PromptFormatRegistry promptFormatRegistry;

    private final ChatService chatService;

    public Generation doAnalyze(String type, Map<String, Object> variables) {
        PromptTemplate template = new PromptTemplate(getPrompt(type));
        Prompt prompt = template.create(variables);
        Generation res = chatService.chat(prompt);
        return res;
    }

    @Override
    public SajuRespDto doAnalyzeSaju(SajuReqDto sajuReqDto) {
        Generation generation = doAnalyze("saju", Map.of(
                "name", sajuReqDto.name(),
                "birthDate", sajuReqDto.birthDate().toString(),
                "birthTime", sajuReqDto.time().getLabel(),
                "sex", sajuReqDto.sex(),
                "format", promptFormatRegistry.getFormatFor(SajuRespDto.class)
        ));
        return parseResponse(generation.getOutput().getText(), SajuRespDto.class);
    }

    @Override
    public FaceRespDto doAnalyzeFace(String imageUrl) {
        Generation generation = doAnalyze("face", Map.of(
                "imageUrl", imageUrl,
                "format", promptFormatRegistry.getFormatFor(FaceRespDto.class)
        ));
        return parseResponse(generation.getOutput().getText(), FaceRespDto.class);
    }

    @Override
    public DreamRespDto doAnalyzeDream(DreamReqDto dreamReqDto) {
        Generation generation = doAnalyze("dream", Map.of(
                "dream", dreamReqDto.dreamExplanation(),
                "format", promptFormatRegistry.getFormatFor(DreamRespDto.class)
        ));
        return parseResponse(generation.getOutput().getText(), DreamRespDto.class);
    }

    @Override
    public TodayRespDto doAnalyzeTodayLuck(String today, SajuReqDto sajuReqDto) {
        Generation generation = doAnalyze("today-luck", Map.of(
                "today", today,
                "name", sajuReqDto.name(),
                "birthDate", sajuReqDto.birthDate().toString(),
                "birthTime", sajuReqDto.time().getLabel(),
                "sex", sajuReqDto.sex(),
                "format", promptFormatRegistry.getFormatFor(TodayRespDto.class)
        ));
        return parseResponse(generation.getOutput().getText(), TodayRespDto.class);
    }

    private Resource getPrompt(String type) {
        return switch (type) {
            case "saju" -> new ClassPathResource("prompt/saju.txt");
            case "dream" -> new ClassPathResource("prompt/dream.txt");
            case "today-luck" -> new ClassPathResource("prompt/today.txt");
            case "face" -> new ClassPathResource("prompt/face.txt");
            default -> throw new IllegalArgumentException("지원하지 않는 분석 타입입니다: " + type);
        };
    }

    private <T> T parseResponse(String response, Class<T> clazz) {
        try {
            return objectMapper.readValue(response, clazz);
        } catch (Exception e) {
            throw new RuntimeException("GPT 응답을 파싱하는 데 실패했습니다.\n\n응답 내용:\n" + response, e);
        }
    }
}
