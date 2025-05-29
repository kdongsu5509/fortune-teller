package com.jangpyeong.fortuneteller.infra.llm;

import com.jangpyeong.fortuneteller.domain.llm.application.AiPromptService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AiPromptServiceImpl implements AiPromptService {

    private final ChatClient chatClient;

    @Override
    public String sendPrompt(Prompt prompt) {
        log.info("Sending prompt to LLM");
        ChatResponse response = chatClient
                .prompt(prompt)    // Prompt 설정
                .call()            // 동기 호출
                .chatResponse();   // ChatResponse 반환

        Generation generation = response.getResults().getFirst();
        String rawText = generation.getOutput().getText();

// JSON 블록만 추출 (```json ... ``` 감싸져 있음)
        String jsonOnly = rawText.replaceAll("(?s)```json\\s*(.*?)\\s*```", "$1").trim();

        log.info("LLM Pure JSON Response:\n{}", jsonOnly);

        return jsonOnly;
    }
}
