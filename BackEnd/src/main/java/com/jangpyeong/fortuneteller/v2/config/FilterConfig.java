package com.jangpyeong.fortuneteller.v2.config;

import com.jangpyeong.fortuneteller.v2.filter.AccessLogFilter;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<AccessLogFilter> accessLogFilter(RabbitTemplate rabbitTemplate) {
        FilterRegistrationBean<AccessLogFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new AccessLogFilter(rabbitTemplate));
        registrationBean.addUrlPatterns("/*");
        registrationBean.setOrder(1);
        return registrationBean;
    }
}
