package com.jangpyeong.fortuneteller.domain.result;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface ResultRepository extends JpaRepository<Result, UUID> {
    Optional<Result> findByUserEmailAndResultType(String email, ResultType type);
    void deleteByUserEmailAndResultType(String email, ResultType type);
}