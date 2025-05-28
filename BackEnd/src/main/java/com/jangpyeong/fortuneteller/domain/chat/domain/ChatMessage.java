package com.jangpyeong.fortuneteller.domain.chat.domain;

import com.jangpyeong.fortuneteller.common.util.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessage extends BaseTimeEntity {

    @Id
    @GeneratedValue
    private UUID chatId;

    @Column(nullable = false)
    private UUID roomId;

    @Column(nullable = false, length = 100)
    @Email
    private String senderEmail;

    @Enumerated(EnumType.STRING)
    private UserType userType;

    @NotNull
    private String message;

    public enum UserType {
        PERSON, AI
    }
}
