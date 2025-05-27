package com.jangpyeong.fortuneteller.domain.analyze.application;

import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.DreamReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.req.SajuReqDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.DreamRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.FaceRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.SajuRespDto;
import com.jangpyeong.fortuneteller.domain.analyze.api.dto.resp.TodayRespDto;

public interface AnalyzeService {

    FaceRespDto doAnalyzeFace(
            String imageUrl
    );

    SajuRespDto doAnalyzeSaju(
            SajuReqDto sajuReqDto
    );

    DreamRespDto doAnalyzeDream(
            DreamReqDto dreamReqDto
    );

    TodayRespDto doAnalyzeTodayLuck(
            String today,
            SajuReqDto sajuReqDto
    );
}
