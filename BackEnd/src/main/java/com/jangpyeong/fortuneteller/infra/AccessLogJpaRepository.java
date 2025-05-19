package com.jangpyeong.fortuneteller.infra;

import com.jangpyeong.fortuneteller.v1.fortune.access.domain.AccessLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccessLogJpaRepository extends JpaRepository<AccessLog, Long> {

}
