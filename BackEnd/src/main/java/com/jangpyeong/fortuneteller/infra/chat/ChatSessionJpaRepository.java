package com.jangpyeong.fortuneteller.infra.chat;

import com.jangpyeong.fortuneteller.domain.chat.domain.ChatSession;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatSessionJpaRepository extends JpaRepository<ChatSession, Long> {
}
