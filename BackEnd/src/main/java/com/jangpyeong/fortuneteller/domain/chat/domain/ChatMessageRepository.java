package com.jangpyeong.fortuneteller.domain.chat.domain;

import java.util.List;
import java.util.UUID;

public interface ChatMessageRepository {
    void save(ChatMessage chatMessage);

    List<ChatMessage> findAllMessagesAtRoom(UUID roomId);
}
