package com.jangpyeong.fortuneteller.infra.access;

import com.jangpyeong.fortuneteller.domain.access.AccessLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccessLogJpaRepository extends JpaRepository<AccessLog, Long> {

}
