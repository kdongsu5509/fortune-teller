package com.jangpyeong.fortuneteller.domain.chat.domain;

import com.jangpyeong.fortuneteller.common.util.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor
public class ChatMessage extends BaseTimeEntity {

    @Id
    @GeneratedValue
    private Long id;

    @Column(nullable = false)
    private Long sessionId;

    @Column(nullable = false, length = 100)
    private String email;

    @Column(nullable = false, name = "content_role")
    private String contentRole;

    @Column(nullable = false, length = 255)
    private String content;

    // 생성자 팩토리
    public static ChatMessage of(Long groupId, String email, String contentRole, String content) {
        return new ChatMessage(groupId, email, contentRole, content);
    }

    // 생성자
    public ChatMessage(
            Long groupId,
            String email,
            String contentRole,
            String content
    ) {
        this.sessionId = groupId;
        this.email = email;
        this.contentRole = contentRole;
        this.content = content;
    }

    public LocalDateTime getCreatedAt() {
        return super.getCreatedAt();
    }
}