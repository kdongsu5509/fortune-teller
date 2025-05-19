package com.jangpyeong.fortuneteller.domain.admin.application;

import com.jangpyeong.fortuneteller.common.response.APIResponse;
import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtAuthRedis;
import com.jangpyeong.fortuneteller.domain.jwt.domain.JwtService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin")
@Tag(description = "관리자 권한 API", name = "관리자 API")
public class AdminController {

    private final JwtService jwtService;

    @GetMapping("/jwt/getAll")
    @Operation(summary = "Jwt 전체조회", description = "Redeis에 존재하는 Access, Refresh 토큰을 전체 조회한다. ")
    public APIResponse<List<JwtAuthRedis>> jwtGetAll() {
        List<JwtAuthRedis> list = jwtService.getJwtInfoAll();
        return APIResponse.success(list);
    }

}
