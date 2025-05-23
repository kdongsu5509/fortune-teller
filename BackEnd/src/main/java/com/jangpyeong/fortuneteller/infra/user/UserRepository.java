package com.jangpyeong.fortuneteller.infra.user;

import com.jangpyeong.fortuneteller.domain.user.domain.User;
import java.util.Optional;

public interface UserRepository {
    Optional<User> findByEmail(String email);

    User save(User user);
}
