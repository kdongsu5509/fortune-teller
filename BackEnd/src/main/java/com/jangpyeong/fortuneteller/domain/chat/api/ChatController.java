//package com.jangpyeong.fortuneteller.domain.chat.api;
//
//import com.jangpyeong.fortuneteller.domain.chat.application.ChatMessageService;
//import com.jangpyeong.fortuneteller.domain.chat.domain.ChatMessage;
//import com.jangpyeong.fortuneteller.domain.llm.application.AiPromptService;
//import java.util.UUID;
//import lombok.RequiredArgsConstructor;
//import org.springframework.messaging.handler.annotation.MessageMapping;
//import org.springframework.messaging.simp.SimpMessagingTemplate;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.PostMapping;
//
//@Controller
//@RequiredArgsConstructor
//public class ChatController {
//
//    private final SimpMessagingTemplate messagingTemplate;
//    private final ChatMessageService chatMessageService;
//    private final AiPromptService aiPromptService;
//
//    @PostMapping("/start")
//    public UUID makeChattingRoomId() {
//        //check the user payed.
//        return UUID.randomUUID();
//    }
//
//    @MessageMapping("/chat/send")
//    public void receiveMessageFromUser(ChatMessage dto) {
//        // 1. 유저 메시지 저장
//        ChatMessage saved = chatMessageService.saveUserMessage(dto);
//
//        // 2. 클라이언트에 유저 메시지 전송
//        messagingTemplate.convertAndSendToUser(
//                dto.getSenderEmail(),
//                "/queue/messages",
//                toDto(saved)
//        );
//
//        // 3. AI 응답 생성 및 저장
//        String aiReply = aiPromptService.reply(dto.getMessage());
//        ChatMessage aiMessage = chatMessageService.saveAiMessage(dto.getRoomId(), dto.getSenderEmail(), aiReply);
//
//        // 4. 클라이언트에 AI 메시지 전송
//        messagingTemplate.convertAndSendToUser(
//                dto.getSenderEmail(),
//                "/queue/messages",
//                toDto(aiMessage)
//        );
//    }
//
//    private ChatMessage toDto(ChatMessage entity) {
//        return ChatMessage.builder()
//                .roomId(entity.getRoomId())
//                .senderEmail(entity.getUserEmail())
//                .userType(entity.getUserType())
//                .message(entity.getMessage())
//                .createdAt(entity.getCreatedAt())
//                .build();
//    }
//}
