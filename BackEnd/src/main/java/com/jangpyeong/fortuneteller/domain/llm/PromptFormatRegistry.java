package com.jangpyeong.fortuneteller.domain.llm;

import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class PromptFormatRegistry {

    public String getFormatFor(ResultType resultType) {
        log.info("Fetching prompt format for result type: {}", resultType);
        return switch (resultType) {
            case SAJU -> sajuFormat();
            case FACE -> faceFormat();
            case DREAM -> dreamFormat();
            case TODAY_LUCK -> todayLuckFormat();
            default -> "{}";
        };
    }

    private String sajuFormat() {
        return """
                {
                  "summary": "예시 요약",
                  "ohaeng": "오행 정보",
                  "personality": "성격 분석",
                  "luck": "운세 정보",
                  "suggestion": "조언"
                }
                """;
    }

    private String faceFormat() {
        return """
                {
                  "summary": "예시 요약",
                  "keywords": ["부드러움", "진지함"],
                  "features": {
                    "eyes": { "description": "눈이 크고 맑다" },
                    "nose": { "description": "콧대가 높다" },
                    "mouth": { "description": "입꼬리가 올라갔다" },
                    "forehead": { "description": "이마가 넓다" }
                  },
                  "advice": "긍정적인 인상을 유지하세요"
                }
                """;
    }

    private String dreamFormat() {
        return """
                {
                  "summary": "꿈의 전체적인 해석",
                  "dream_type": "길몽",
                  "symbol_meanings": [
                    { "symbol": "물고기", "meaning": "재물과 행운을 뜻함" },
                    { "symbol": "산", "meaning": "안정과 장벽을 의미함" }
                  ],
                  "advice": "기회를 잡을 준비를 하세요"
                }
                """;
    }

    private String todayLuckFormat() {
        return """
                {
                  "summary": "오늘의 전반적인 운세 요약",
                  "keywords": ["기회", "도전", "희망"],
                  "lucky_color": "파란색",
                  "lucky_number": 7,
                  "lucky_direction": "동쪽",
                  "categories": {
                    "general": { "description": "오늘은 도전하기 좋은 날입니다" },
                    "money": { "description": "작은 이익이 예상됩니다" },
                    "love": { "description": "새로운 인연을 기대해도 좋습니다" },
                    "health": { "description": "무리한 활동은 피하세요" }
                  },
                  "advice": "긍정적인 태도를 유지하세요"
                }
                """;
    }
}
