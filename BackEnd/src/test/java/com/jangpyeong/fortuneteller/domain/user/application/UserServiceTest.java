package com.jangpyeong.fortuneteller.domain.user.application;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.jangpyeong.fortuneteller.domain.user.domain.User;
import com.jangpyeong.fortuneteller.domain.user.domain.UserCommand.Signup;
import com.jangpyeong.fortuneteller.infra.user.UserRepository;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

class UserServiceTest {

    private UserRepository userRepository;
    private BCryptPasswordEncoder passwordEncoder;
    private UserService userService;

    @BeforeEach
    void setup() {
        userRepository = mock(UserRepository.class);
        passwordEncoder = mock(BCryptPasswordEncoder.class);
        userService = new UserService(userRepository, passwordEncoder);
    }

    @Test
    void 회원가입_성공() {
        // given
        String email = "test@example.com";
        String rawPassword = "password123";
        String encodedPassword = "encoded_password123";
        Signup command = Signup.of(email, rawPassword);

        when(userRepository.findByEmail(email)).thenReturn(Optional.empty());
        when(passwordEncoder.encode(rawPassword)).thenReturn(encodedPassword);

        // 👇 이 줄이 중요!
        when(userRepository.save(any(User.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);

        // when
        userService.saveUser(command);

        // then
        verify(userRepository).save(captor.capture());
        User savedUser = captor.getValue();

        assertThat(savedUser.getEmail()).isEqualTo(email);
        assertThat(savedUser.getPassword()).isEqualTo(encodedPassword);
        assertThat(savedUser.getRole()).isEqualTo("ROLE_USER");
    }

    @Test
    void 회원가입_중복이메일_실패() {
        // given
        String email = "duplicate@example.com";
        Signup command = Signup.of(email, "password123");

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(mock(User.class)));

        // when & then
        assertThatThrownBy(() -> userService.saveUser(command))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("already exists");

        verify(userRepository, never()).save(any());
    }
}
