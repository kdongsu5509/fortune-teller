package com.jangpyeong.fortuneteller.infra.access_log;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@Getter
@Setter
@ConfigurationProperties(prefix = "spring.rabbitmq")
public class RabbitmqProperties {
    private String host;
    private int port;
    private String username;
    private String password;
}
