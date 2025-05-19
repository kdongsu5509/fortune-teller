package com.jangpyeong.fortuneteller.interfaces.analyze;

import com.jangpyeong.fortuneteller.domain.analyze.application.AnalyzeService;
import com.jangpyeong.fortuneteller.domain.analyze.dao.DreamDto;
import com.jangpyeong.fortuneteller.domain.analyze.dao.FaceDto;
import com.jangpyeong.fortuneteller.domain.analyze.dao.SajuDto;
import com.jangpyeong.fortuneteller.domain.analyze.dao.TodayLuckDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "Analyze", description = "AI 분석 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/analyze")
public class AnalyzeController {

    private final AnalyzeService analyzeService;

    @Operation(summary = "관상 분석", description = "얼굴 이미지 URL 기반으로 관상 분석 결과를 반환합니다.")
    @PostMapping("/face")
    public FaceDto analyzeFace(@RequestParam("imgAddress") String imgAddress) {
        return analyzeService.doAnalyzeFace(imgAddress);
    }

    @Operation(summary = "평생 사주 분석", description = "생년월일, 성별 기반으로 평생 사주 운세를 분석합니다.")
    @PostMapping("/saju")
    public SajuDto analyzeSaju(@RequestParam("birthdate") String birthdate,
                               @RequestParam("gender") String gender) {
        return analyzeService.doAnalyzeSaju(birthdate, gender);
    }

    @Operation(summary = "오늘의 운세 분석", description = "오늘 날짜 기준으로 사주 운세를 분석합니다.")
    @PostMapping("/todayLuck")
    public TodayLuckDto analyzeTodayLuck(@RequestParam("birthdate") String birthdate,
                                         @RequestParam("gender") String gender,
                                         @RequestParam("today") String today) {
        return analyzeService.doAnalyzeTodayLuck(birthdate, gender, today);
    }

    @Operation(summary = "꿈 해몽 분석", description = "꿈 내용을 기반으로 해몽 결과를 분석합니다.")
    @PostMapping("/dream")
    public DreamDto analyzeDream(@RequestParam("text") String text) {
        return analyzeService.doAnalyzeDream(text);
    }
}