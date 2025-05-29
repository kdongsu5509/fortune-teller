package com.jangpyeong.fortuneteller.domain.llm.application;

import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;

@Service
public interface AiPromptService {

    String sendPrompt(Prompt prompt);
}
