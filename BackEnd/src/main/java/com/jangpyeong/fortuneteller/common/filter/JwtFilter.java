package com.jangpyeong.fortuneteller.common.filter;

import static com.jangpyeong.fortuneteller.common.util.CommUtils.LOGIN_URL;

import com.jangpyeong.fortuneteller.common.util.JsonUtils;
import com.jangpyeong.fortuneteller.domain.jwt.application.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

@Slf4j
@RequiredArgsConstructor
public class JwtFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final RabbitTemplate rabbitTemplate;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        ContentCachingRequestWrapper req = new ContentCachingRequestWrapper(request);
        ContentCachingResponseWrapper res = new ContentCachingResponseWrapper(response);
        String uri = request.getRequestURI();
        LocalDateTime requestAt = LocalDateTime.now();

        try {
            if (uri.equals(LOGIN_URL)) {
                filterChain.doFilter(req, res);
                return;
            }

            String validAccessToken = jwtService.ValidAccess(req);
            if (validAccessToken == null) {
                validAccessToken = jwtService.reissueAccessByRefresh(req);
                if (validAccessToken == null) {
                    filterChain.doFilter(req, res);
                    logAccess(req, res, requestAt);
                    return;
                }
            }

            log.info("JWT valid success : {}", validAccessToken);
            Authentication authentication = jwtService.getAuthentication(validAccessToken);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            filterChain.doFilter(req, res);

        } finally {
            logAccess(req, res, requestAt);
            res.copyBodyToResponse();
        }
    }


    private void logAccess(ContentCachingRequestWrapper req, ContentCachingResponseWrapper res,
                           LocalDateTime requestAt) {
        LocalDateTime responseAt = LocalDateTime.now();

        String requestBody = new String(req.getContentAsByteArray(), StandardCharsets.UTF_8);
        String responseBody = new String(res.getContentAsByteArray(), StandardCharsets.UTF_8);

        String headers = Collections.list(req.getHeaderNames()).stream()
                .collect(Collectors.toMap(h -> h, req::getHeader))
                .toString();

        AccessLogRequest accessLog = AccessLogRequest.of(
                req.getMethod(),
                req.getRequestURI(),
                req.getQueryString(),
                requestBody,
                responseBody,
                headers,
                req.getHeader("User-Agent"),
                AccessLogRequest.extractClientIp(req),
                res.getStatus(),
                Thread.currentThread().getName(),
                requestAt,
                responseAt
        );

        log.info("AccessLog : {}", JsonUtils.toJson(accessLog));
        rabbitTemplate.convertAndSend("exchange.access.log", "route.access.log.save", accessLog.toCommand());
    }
}
