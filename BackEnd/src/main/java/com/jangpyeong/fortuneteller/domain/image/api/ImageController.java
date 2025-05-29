package com.jangpyeong.fortuneteller.domain.image.api;

import com.jangpyeong.fortuneteller.domain.image.application.ImageService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
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

    private final ImageService imageService;

    @PostMapping
    public String uploadImage(MultipartFile file) {
        return imageService.upload(file);
    }

    @DeleteMapping
    public void deleteImage(String imageUrl) {
        imageService.delete(imageUrl);
    }
}
