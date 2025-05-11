package com.jangpyeong.fortuneteller.v2.infra.access;

import com.jangpyeong.fortuneteller.v2.domain.access.AccessLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccessLogJpaRepository extends JpaRepository<AccessLog, Long> {

}
