package com.jangpyeong.fortuneteller.domain.chat.application;

import com.jangpyeong.fortuneteller.domain.chat.domain.ChatMessage;
import java.util.UUID;

public interface ChatMessageService {

    ChatMessage saveUserMessage(ChatMessage dto);

    ChatMessage saveAiMessage(UUID roomId, String userEmail, String reply);
}
