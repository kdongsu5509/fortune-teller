package com.jangpyeong.fortuneteller.domain.user.application;

import com.jangpyeong.fortuneteller.common.util.JsonUtils;
import com.jangpyeong.fortuneteller.domain.user.domain.User;
import com.jangpyeong.fortuneteller.domain.user.domain.UserCommand.Signup;
import com.jangpyeong.fortuneteller.infra.user.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public void saveUser(Signup command) {
        final String encodedPassword = passwordEncoder.encode(command.getPassword());
        final String role = "ROLE_USER";

        isDuplicated(command.getEmail());
        User user = User.create(command.getEmail(), encodedPassword, role);
        User resSignUp = userRepository.save(user);

        log.info("User signup successful : {}", JsonUtils.toJson(resSignUp));
    }

    private void isDuplicated(String email) {
        userRepository.findByEmail(email).ifPresent(user -> {
            throw new RuntimeException("User with email " + email + " already exists");
        });
    }
}
