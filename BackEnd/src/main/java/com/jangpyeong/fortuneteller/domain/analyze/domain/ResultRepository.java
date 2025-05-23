package com.jangpyeong.fortuneteller.domain.analyze.domain;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResultRepository extends JpaRepository<Result, UUID> {
    Optional<Result> findByUserEmailAndResultType(String email, ResultType type);

    void deleteByUserEmailAndResultType(String email, ResultType type);
}