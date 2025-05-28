// infra/analyze/ResultJpaRepository.java
package com.jangpyeong.fortuneteller.infra.analyze;

import com.jangpyeong.fortuneteller.domain.analyze.domain.Result;
import com.jangpyeong.fortuneteller.domain.analyze.domain.ResultType;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResultJpaRepository extends JpaRepository<Result, UUID> {
    Page<Result> findByUserEmailAndResultType(String userEmail, ResultType resultType, Pageable pageable);
}
