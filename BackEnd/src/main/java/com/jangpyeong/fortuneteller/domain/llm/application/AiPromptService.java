package com.jangpyeong.fortuneteller.domain.llm.application;

import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;

public interface AiPromptService {

    Generation sendPrompt(Prompt prompt);
}
