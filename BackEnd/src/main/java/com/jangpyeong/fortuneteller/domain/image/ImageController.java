package com.jangpyeong.fortuneteller.domain.image;

import com.jangpyeong.fortuneteller.domain.analyze.application.ImageService;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/image")
public class ImageController {

    ImageService imageService;

    @PostMapping("/upload")
    public void uploadImage(MultipartFile file) {
        try {
            imageService.uploadImgae(file);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
