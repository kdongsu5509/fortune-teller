package com.jangpyeong.fortuneteller.domain.image.application;

import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
    String upload(MultipartFile file);

    void delete(String imgAddress);
}
