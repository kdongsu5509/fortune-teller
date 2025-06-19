package com.jangpyeong.fortuneteller.domain.analyze.api;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.AnalysisResultRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.application.service.ResultService;
import com.jangpyeong.fortuneteller.domain.user.domain.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "Result", description = "AI 분석 결과 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/result")
public class ResultController {

    private final ResultService resultService;

    @Operation(summary = "분석 결과 삭제", description = "사용자의 분석 결과를 삭제합니다.")
    @DeleteMapping
    public void deleteAnalysisResult(@RequestParam UUID id) {
        resultService.delete(id);
    }

    @Operation(summary = "관상 분석 결과 전체 조회", description = "사용자의 관상 분석 결과를 전체 조회합니다.")
    @GetMapping("/face")
    public AnalysisResultRespDto getFaceAnalysisResults(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        return resultService.getSomeFaceAnalysis(userDetails.getUsername(), page, size);
    }

    @Operation(summary = "사주 분석 결과 전체 조회", description = "사용자의 사주 분석 결과를 전체 조회합니다.")
    @GetMapping("/saju")
    public AnalysisResultRespDto getSajuAnalysisResults(@AuthenticationPrincipal CustomUserDetails userDetails,
                                                        @RequestParam(defaultValue = "0") int page,
                                                        @RequestParam(defaultValue = "10") int size) {
        return resultService.getSomeSajuAnalysis(userDetails.getUsername(), page, size);
    }

    @Operation(summary = "오늘의 운세 분석 결과 전체 조회", description = "사용자의 오늘의 운세 분석 결과를 전체 조회합니다.")
    @GetMapping("/todayLuck")
    public AnalysisResultRespDto getTodayLuckAnalysisResults(@AuthenticationPrincipal CustomUserDetails userDetails,
                                                             @RequestParam(defaultValue = "0") int page,
                                                             @RequestParam(defaultValue = "10") int size) {
        return resultService.getSomeTodayLuckAnalysis(userDetails.getUsername(), page, size);
    }

    @Operation(summary = "꿈 해몽 분석 결과 전체 조회", description = "사용자의 꿈 해몽 분석 결과를 전체 조회합니다.")
    @GetMapping("/dream")
    public AnalysisResultRespDto getDreamAnalysisResults(@AuthenticationPrincipal CustomUserDetails userDetails,
                                                         @RequestParam(defaultValue = "0") int page,
                                                         @RequestParam(defaultValue = "10") int size) {
        return resultService.getSomeDreamAnalysis(userDetails.getUsername(), page, size);
    }
}