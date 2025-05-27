package com.jangpyeong.fortuneteller.domain.chat.domain;


public record ChatRedisMessage(
        String role,
        String content,
        String timestamp
) {
    public String toJson() {
        return String.format("""
                {
                  "role": "%s",
                  "content": "%s",
                  "timestamp": "%s"
                }
                """, role, content, timestamp);
    }
}
