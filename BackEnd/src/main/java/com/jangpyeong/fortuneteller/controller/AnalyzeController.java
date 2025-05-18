package com.jangpyeong.fortuneteller.controller;

import com.jangpyeong.fortuneteller.dto.AnalyzeResultDTO;
import com.jangpyeong.fortuneteller.repository.UserCountRepository;
import com.jangpyeong.fortuneteller.service.AnalyzeService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/analyze")
public class AnalyzeController {

    AnalyzeService analyzeService;
    UserCountRepository userCountRepository;

    @Tag(name = "Response Estimate", description = "Response Estimate API")
    @PostMapping("/face")
    public AnalyzeResultDTO analyzeFace(@RequestParam("imgAddress") String imgAddress) {

        try {
            userCountRepository.increaseUserCount();
            return analyzeService.analyzeImage(imgAddress);
        } catch (Exception e) {
            return null;
        }
    }


}
