package com.jangpyeong.fortuneteller.infra.v1_infra.access;

import com.jangpyeong.fortuneteller.common.util.JsonUtils;
import com.jangpyeong.fortuneteller.infra.AccessLogConsumerCommand;
import com.jangpyeong.fortuneteller.infra.AccessLogJpaRepository;
import com.jangpyeong.fortuneteller.v1.fortune.access.domain.AccessLog;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
@Profile("consumer")
public class AccessLogConsumerService {

    private final AccessLogJpaRepository accessLogJpaRepository;

    @RabbitListener(queues = "queue.access.log.save", concurrency = "1")
    public void saveAccessLog(AccessLogConsumerCommand.Save command) {
        try {
            AccessLog accessLog = AccessLog.of(command);
            accessLogJpaRepository.save(accessLog);
            log.info("Save access log: {}", JsonUtils.toJson(accessLog));

        } catch (Exception e) {
            log.error("AccessLog Save error : {},{}", e.getMessage(), JsonUtils.toJson(command));
        }
    }

}
