package com.jangpyeong.fortuneteller.domain.jwt.domain;

import jakarta.persistence.Id;
import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.index.Indexed;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@RedisHash(value = "JwtAuth")
public class JwtAuthRedis implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    private String id;

    @Indexed
    private String accessToken;

    @Indexed
    private String refreshToken;

    @Indexed
    private String email;
    private LocalDateTime refreshExpiration;
    private LocalDateTime accessExpiration;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;

}


