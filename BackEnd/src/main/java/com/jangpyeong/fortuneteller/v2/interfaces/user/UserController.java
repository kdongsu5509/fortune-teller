package com.jangpyeong.fortuneteller.v2.interfaces.user;

import com.jangpyeong.fortuneteller.v2.domain.user.UserCommand;
import com.jangpyeong.fortuneteller.v2.domain.user.UserService;
import com.jangpyeong.fortuneteller.v2.support.response.APIResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
@Tag(description = "유저관련 API", name = "유저 API")
public class UserController {

    private final UserService userService;

    @PostMapping("/signup")
    public APIResponse<Void> signup(@RequestBody @Valid UserRequest.SignUp request) {
        userService.saveUser(UserCommand.Signup.of(request.getEmail(), request.getPassword()));
        return APIResponse.success();
    }
}
