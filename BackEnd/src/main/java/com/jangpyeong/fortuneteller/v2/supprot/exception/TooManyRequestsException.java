package com.jangpyeong.fortuneteller.v2.supprot.exception;

public class TooManyRequestsException extends RuntimeException{
    public TooManyRequestsException(String message) {
        super(message);
    }
}
