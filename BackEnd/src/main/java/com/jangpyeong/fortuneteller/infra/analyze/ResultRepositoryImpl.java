// infra/analyze/ResultRepositoryImpl.java
package com.jangpyeong.fortuneteller.infra.analyze;

import com.jangpyeong.fortuneteller.domain.analyze.domain.Result;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultRepository;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.util.Optional;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ResultRepositoryImpl implements ResultRepository {

    private final ResultJpaRepository jpa;

    @Override
    public Result save(Result result) {
        return jpa.save(result);
    }

    @Override
    public void deleteById(UUID id) {
        jpa.deleteById(id);
    }

    @Override
    public Optional<Result> findById(UUID id) {
        return jpa.findById(id);
    }

    @Override
    public Page<Result> findByUserEmailAndResultType(String userEmail, ResultType resultType, Pageable pageable) {
        return jpa.findByUserEmailAndResultType(userEmail, resultType, pageable);
    }
}
