package com.jangpyeong.fortuneteller.domain.analyze.domain;

import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ResultService {

    private final ResultRepository resultRepository;
    private final ResultCacheRepository cacheRepository;

    public ResultCacheDto getResult(String email, ResultType type) {
        ResultCacheDto cached = cacheRepository.get(email, type);
        if (cached != null) {
            return cached;
        }

        Result result = resultRepository.findByUserEmailAndResultType(email, type)
                .orElseThrow(() -> new NoSuchElementException("결과 없음"));

        ResultCacheDto dto = toDto(result);
        cacheRepository.set(email, type, dto);
        return dto;
    }

    public void saveResult(String result) {
//        resultRepository.save(result);
//        cacheRepository.set(result.getUser().getEmail(), result.replace(), toDto(result));
    }

    public void deleteResult(String email, ResultType type) {
        resultRepository.deleteByUserEmailAndResultType(email, type);
        cacheRepository.delete(email, type);
    }

    private ResultCacheDto toDto(Result result) {
        return ResultCacheDto.builder()
                .uuid(result.getUuid())
                .resultType(result.getResultType())
                .summary(result.getSummary())
                .build();
    }
}
