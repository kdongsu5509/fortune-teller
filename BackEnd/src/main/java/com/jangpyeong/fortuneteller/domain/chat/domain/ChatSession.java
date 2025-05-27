package com.jangpyeong.fortuneteller.domain.chat.domain;

import com.jangpyeong.fortuneteller.common.util.BaseTimeEntity;
import com.jangpyeong.fortuneteller.domain.user.domain.User;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Entity
@RequiredArgsConstructor
@Table(name = "chat_session")
public class ChatSession extends BaseTimeEntity {

    @Id
    @Getter
    @GeneratedValue
    private Long sessionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "email")
    private User user;

    public ChatSession(User user) {
        this.user = user;
    }
}
