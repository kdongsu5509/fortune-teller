//package com.jangpyeong.fortuneteller.domain.chat.application;
//
//import com.jangpyeong.fortuneteller.domain.chat.domain.ChatMessage;
//import com.jangpyeong.fortuneteller.domain.chat.domain.ChatMessage.UserType;
//import com.jangpyeong.fortuneteller.domain.chat.domain.ChatMessageRepository;
//import java.util.UUID;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//@Service
//@RequiredArgsConstructor
//public class ChatMessageServiceImpl implements ChatMessageService {
//
//    private final ChatMessageRepository chatMessageRepository;
//
//    @Override
//    public ChatMessage saveUserMessage(ChatMessage dto) {
//        ChatMessage message = ChatMessage.of(
//                dto.getRoomId(),
//                dto.getSenderEmail(),
//                UserType.PERSON,
//                dto.getMessage()
//        );
//        return chatMessageRepository.save(message);
//    }
//
//    @Override
//    public ChatMessage saveAiMessage(UUID roomId, String userEmail, String reply) {
//        ChatMessage aiMessage = ChatMessage.of(
//                roomId,
//                userEmail,
//                UserType.AI,
//                reply
//        );
//        return chatMessageRepository.save(aiMessage);
//    }
//}
