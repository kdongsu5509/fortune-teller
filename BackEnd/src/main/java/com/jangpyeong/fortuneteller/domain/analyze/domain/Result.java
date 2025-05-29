package com.jangpyeong.fortuneteller.domain.analyze.domain;

import com.jangpyeong.fortuneteller.common.util.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.UUID;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Table(name = "results")
@Entity
@Getter
@Builder
@AllArgsConstructor
@RequiredArgsConstructor(access = AccessLevel.PROTECTED)
public class Result extends BaseTimeEntity {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "user_email", nullable = false, length = 100)
    private String userEmail;

    @Enumerated(EnumType.STRING)
    private ResultType resultType;

    private String contents;

    public static Result create(String userEmail, ResultType resultType, String contents) {
        return Result.builder()
                .userEmail(userEmail)
                .resultType(resultType)
                .contents(contents)
                .build();
    }
}
