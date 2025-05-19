package com.jangpyeong.fortuneteller.domain.result;

import java.io.Serializable;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResultCacheDto implements Serializable {
    private UUID uuid;
    private ResultType resultType;
    private String summary;
}