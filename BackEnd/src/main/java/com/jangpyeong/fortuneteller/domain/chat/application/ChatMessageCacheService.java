package com.jangpyeong.fortuneteller.domain.chat.application;

import com.jangpyeong.fortuneteller.domain.chat.domain.ChatRedisMessage;
import java.util.List;

public interface ChatMessageCacheService {

    void appendMessage(Long sessionId, ChatRedisMessage message, String jwt, String chatRole);

    List<ChatRedisMessage> getMessages(Long sessionId);

    void clearHistory(String sessionId);
}
