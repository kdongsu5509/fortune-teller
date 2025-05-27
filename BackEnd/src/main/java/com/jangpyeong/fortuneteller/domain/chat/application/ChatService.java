package com.jangpyeong.fortuneteller.domain.chat.application;

import com.jangpyeong.fortuneteller.domain.chat.api.ChatResponseDto;
import java.util.List;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;

public interface ChatService {

    Generation chat(Prompt prompt);
//    chatModel.call(prompt).getResult()

    String chat(String message, List<String> previousMessages);

    ChatResponseDto chat(String email, String userMessage);

    Long initializeChat(String jwt);
}
