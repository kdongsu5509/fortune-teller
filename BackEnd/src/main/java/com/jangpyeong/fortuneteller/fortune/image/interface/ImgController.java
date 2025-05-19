package com.jangpyeong.fortuneteller.interfaces.image;

import com.jangpyeong.fortuneteller.infra.cloud.ImageService;
import groovy.util.logging.Slf4j;
import java.io.IOException;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@lombok.extern.slf4j.Slf4j
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/")
public class ImgController {

    private ImageService imgService;

    @PostMapping("image")
    public String upload(@RequestParam("img") MultipartFile img) throws IOException {

        String s3Url = imgService.uploadImage(img);
        log.info("Image uploaded to: " + s3Url);
        return s3Url;
    }

    @DeleteMapping("image")
    public String delete(@RequestParam("imgAddress") String imgAddress) {
        imgService.deleteImage(imgAddress);
        return "success";
    }
}
