package com.jangpyeong.fortuneteller.domain.image.api;

import com.jangpyeong.fortuneteller.domain.image.application.ImageService;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/image")
@Tag(
        name = "Image",
        description = "이미지 업로드 API"
)
public class ImageController {

    ImageService imageService;

    @PostMapping("/upload")
    public String uploadImage(MultipartFile file) {
        String uploadedAddress;
        try {
            uploadedAddress = imageService.uploadImgae(file);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return uploadedAddress;
    }
}
