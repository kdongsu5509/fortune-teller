// domain/analyze/domain/ResultRepository.java
package com.jangpyeong.fortuneteller.domain.analyze.domain;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ResultRepository {

    Result save(Result result);

    void deleteById(UUID id);

    Optional<Result> findById(UUID id);

    Page<Result> findByUserEmailAndResultType(String userEmail, ResultType resultType, Pageable pageable);
}
