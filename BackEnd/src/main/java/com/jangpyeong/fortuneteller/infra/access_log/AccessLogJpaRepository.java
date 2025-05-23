package com.jangpyeong.fortuneteller.infra.access_log;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AccessLogJpaRepository extends JpaRepository<AccessLog, Long> {

}
