package com.jangpyeong.fortuneteller.v2.supprot.exception;

import com.jangpyeong.fortuneteller.v2.supprot.response.APIResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.stream.Collectors;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(BindException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public APIResponse<Object> handleBindException(BindException e) {
        String message = e.getBindingResult().getAllErrors().stream()
                .map(DefaultMessageSourceResolvable::getDefaultMessage)
                .distinct()
                .collect(Collectors.joining(", "));

        log.warn("BindException 발생: {}", message);

        return APIResponse.fail(HttpStatus.BAD_REQUEST.value(), message);
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public APIResponse<Object> handleRuntimeException(RuntimeException e) {
        log.warn("RuntimeException 발생: {}", e.getMessage());
        return APIResponse.fail(HttpStatus.BAD_REQUEST.value(), e.getMessage());
    }

    @ExceptionHandler(TooManyRequestsException.class)
    @ResponseStatus(HttpStatus.TOO_MANY_REQUESTS)
    public APIResponse<Object> handleTooManyRequests(TooManyRequestsException e) {
        log.warn("TooManyRequestsException 발생: {}", e.getMessage());
        return APIResponse.fail(HttpStatus.TOO_MANY_REQUESTS.value(), e.getMessage());
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public APIResponse<Object> handleGeneralException(Exception e) {
        log.error("Unhandled Exception 발생: ", e);
        return APIResponse.fail(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 못한 오류가 발생했습니다.");
    }
}