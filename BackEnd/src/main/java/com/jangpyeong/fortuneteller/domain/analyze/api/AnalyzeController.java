package com.jangpyeong.fortuneteller.domain.analyze.api;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.DreamReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.FaceReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.SajuReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.DreamRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.FaceRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.SajuRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.TodayRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.application.service.AnalyzeService;
import com.jangpyeong.fortuneteller.domain.user.domain.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
    public FaceRespDto analyzeFace(FaceReqDto faceReqDto, @AuthenticationPrincipal CustomUserDetails userDetails) {
        return analyzeService.doAnalyzeFace(faceReqDto.imageUrl(), userDetails.getUsername());
    }

    @Operation(summary = "평생 사주 분석", description = "생년월일, 성별 기반으로 평생 사주 운세를 분석합니다.")
    @PostMapping("/saju")
    public SajuRespDto analyzeSaju(SajuReqDto sajuReqDto, @AuthenticationPrincipal CustomUserDetails userDetails) {
        return analyzeService.doAnalyzeSaju(sajuReqDto, userDetails.getUsername());
    }

    @Operation(summary = "오늘의 운세 분석", description = "오늘 날짜 기준으로 사주 운세를 분석합니다.")
    @PostMapping("/todayLuck")
    public TodayRespDto analyzeTodayLuck(
            @RequestParam String today,
            @RequestBody SajuReqDto sajuReqDto,
            @AuthenticationPrincipal CustomUserDetails userDetails
    ) {
        return analyzeService.doAnalyzeTodayLuck(today, sajuReqDto, userDetails.getUsername());
    }

    @Operation(summary = "꿈 해몽 분석", description = "꿈 내용을 기반으로 해몽 결과를 분석합니다.")
    @PostMapping("/dream")
    public DreamRespDto analyzeDream(@RequestBody DreamReqDto dreamReqDto,
                                     @AuthenticationPrincipal CustomUserDetails userDetails) {
        return analyzeService.doAnalyzeDream(dreamReqDto, userDetails.getUsername());
    }
}