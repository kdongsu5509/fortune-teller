package com.jangpyeong.fortuneteller.domain.analyze.application;

import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
    String uploadImgae(MultipartFile file) throws IOException;

    void deleteImage(String imgAddress);

    String getImageUrl(String imgAddress);
}
