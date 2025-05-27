package com.jangpyeong.fortuneteller.domain.chat.application;

import com.jangpyeong.fortuneteller.domain.chat.api.ChatResponseDto;
import com.jangpyeong.fortuneteller.domain.chat.domain.ChatSession;
import com.jangpyeong.fortuneteller.domain.user.domain.User;
import com.jangpyeong.fortuneteller.infra.chat.ChatSessionJpaRepository;
import com.jangpyeong.fortuneteller.infra.jwt.JwtUtil;
import com.jangpyeong.fortuneteller.infra.user.UserRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {
    private final UserRepository userRepository;
    private final ChatSessionJpaRepository chatSessionRepository;
    private final ChatModel chatModel;
    private final JwtUtil jwtUtil;

    @Override
    public Generation chat(Prompt prompt) {
        return chatModel.call(prompt).getResult();
    }

    @Override
    public String chat(String message, List<String> previousMessages) {
        String previousMessage = String.join("\n", previousMessages);
        Prompt prompt = new Prompt(previousMessage);

        return chat(prompt).getOutput().getText();
    }

    @Override
    public ChatResponseDto chat(String email, String userMessage) {
        //과거 채팅 내역을 가져온다.

        //TODO: 이력 가져오는 로직 추가
        //새로운 프롬프트를 생성한다.

        //요청한다.
        return new ChatResponseDto(
                "감사합니다"
        );
    }

    @Override
    public Long initializeChat(String jwt) {
        //사용자 조회
        String username = jwtUtil.getUsername(jwt);
        User user = userRepository.findByEmail(username).orElseThrow(
                () -> new RuntimeException("User not found")
        );

        //ChatSession 생성
        ChatSession chatSession = new ChatSession(
                user
        );

        ChatSession save = chatSessionRepository.save(chatSession);

        //ChatSession ID 반환
        return save.getSessionId();
    }
}
