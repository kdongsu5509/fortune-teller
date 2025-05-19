package com.jangpyeong.fortuneteller.infra.cloud;

import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
    String uploadImgae(MultipartFile file) throws IOException;

    String uploadImage(MultipartFile file) throws IOException;

    void deleteImage(String imgAddress);

    String getImageUrl(String imgAddress);
}
