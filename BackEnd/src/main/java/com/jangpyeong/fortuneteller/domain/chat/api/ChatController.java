package com.jangpyeong.fortuneteller.domain.chat.api;

import com.jangpyeong.fortuneteller.domain.chat.application.ChatService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@Tag(name = "GPT 요청", description = "Request To Open AI API")
@RequestMapping("/api/chat")
public class ChatController {

    private final ChatService chatService;

    @PostMapping("/init")
    @Operation(summary = "GPT와 대화 시작", description = "GPT와의 대화를 시작합니다.")
    public Long initChat(HttpServletRequest req) {
        return chatService.initializeChat(
                req.getAttribute("jwt").toString()); // 예시로 1을 반환합니다. 실제로는 생성된 groupId를 반환해야 합니다.
    }

    @Operation(summary = "GPT 요청", description = "GPT에게 요청을 보냅니다.")
    @PostMapping
    public ResponseEntity<ChatResponseDto> chat(@RequestBody ChatRequestDto requestDto,
                                                HttpServletRequest request) {
        // 1. JWT에서 사용자 이메일 추출 (예시)
        String jwt = request.getAttribute("jwt").toString(); // 필터에서 넣어둔 경우

        // 2. ChatService 호출
        ChatResponseDto response = chatService.chat(jwt, requestDto.message());

        // 3. 응답 반환
        return ResponseEntity.ok(response);
    }
}
