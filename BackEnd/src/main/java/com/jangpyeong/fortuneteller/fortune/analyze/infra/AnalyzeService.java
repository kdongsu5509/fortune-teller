package com.jangpyeong.fortuneteller.infra.openAI;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jangpyeong.fortuneteller.domain.result.Result;
import com.jangpyeong.fortuneteller.domain.result.ResultService;
import com.jangpyeong.fortuneteller.infra.openAI.response.DreamDto;
import com.jangpyeong.fortuneteller.infra.openAI.response.FaceDto;
import com.jangpyeong.fortuneteller.infra.openAI.response.SajuDto;
import com.jangpyeong.fortuneteller.infra.openAI.response.TodayLuckDto;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnalyzeService {

    private final ChatModel chatModel;
    private final ResultService resultService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public Generation doAnalyze(String type, Map<String, Object> variables) {
        PromptTemplate template = new PromptTemplate(getPrompt(type));
        Prompt prompt = template.create(variables);
        return chatModel.call(prompt).getResult();
    }

    public SajuDto doAnalyzeSaju(String birthdate, String gender) {
        Generation gen = doAnalyze("saju", Map.of("birthdate", birthdate, "gender", gender));
        return parseResponse(gen.getOutput().getText(), SajuDto.class);
    }

    public DreamDto doAnalyzeDream(String dream) {
        Generation gen = doAnalyze("dream", Map.of("text", dream));
        return parseResponse(gen.getOutput().getText(), DreamDto.class);
    }

    public TodayLuckDto doAnalyzeTodayLuck(String birthdate, String gender, String today) {
        Generation gen = doAnalyze("today-luck", Map.of("birthdate", birthdate, "gender", gender, "today", today));
        return parseResponse(gen.getOutput().getText(), TodayLuckDto.class);
    }

    public FaceDto doAnalyzeFace(String imageUrl) {
        Generation gen = doAnalyze("face", Map.of("imageUrl", imageUrl));
        return parseResponse(gen.getOutput().getText(), FaceDto.class);
    }

    private Resource getPrompt(String type) {
        return switch (type) {
            case "saju" -> new ClassPathResource("prompt/saju.txt");
            case "dream" -> new ClassPathResource("prompt/dream.txt");
            case "today-luck" -> new ClassPathResource("prompt/today_luck.txt");
            case "face" -> new ClassPathResource("prompt/face.txt");
            default -> throw new IllegalArgumentException("지원하지 않는 분석 타입입니다: " + type);
        };
    }

    private <T> T parseResponse(String response, Class<T> clazz) {
        try {
            T dto = objectMapper.readValue(response, clazz);

            // 👉 Result 엔티티 생성 및 저장
            //TODO: 수정필요
            resultService.saveResult(extractResultFromDto(dto));

            return dto;

        } catch (JsonProcessingException e) {
            throw new RuntimeException("❗ GPT 응답을 파싱하는 데 실패했습니다.\n\n응답 내용:\n" + response, e);
        }
    }


    private <T> String extractResultFromDto(T dto) {
        if (dto instanceof FaceDto face) {
            return new Result(face.getSummary(), ResultType.FACE, currentUser());
        } else if (dto instanceof SajuDto saju) {
            return new Result(saju.getSummary(), ResultType.SAJU, currentUser());
        } else if (dto instanceof DreamDto dream) {
            return new Result(dream.getSummary(), ResultType.DREAM, currentUser());
        } else if (dto instanceof TodayLuckDto luck) {
            return new Result(luck.getSummary(), ResultType.TODAY_LUCK, currentUser());
        } else {
            throw new IllegalArgumentException("지원하지 않는 분석 타입입니다: " + dto.getClass());
        }
    }

}
