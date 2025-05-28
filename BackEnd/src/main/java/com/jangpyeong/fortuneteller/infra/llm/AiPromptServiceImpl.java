package com.jangpyeong.fortuneteller.infra.llm;

import com.jangpyeong.fortuneteller.domain.llm.application.AiPromptService;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AiPromptServiceImpl implements AiPromptService {

    private final ChatClient chatClient;

    @Override
    public Generation sendPrompt(Prompt prompt) {
        ChatResponse response = chatClient
                .prompt(prompt)    // Prompt 설정
                .call()            // 동기 호출
                .chatResponse();   // ChatResponse 반환

        assert response != null;
        return response.getResults().getFirst(); // 첫 번째 Generation 반환
    }
}
