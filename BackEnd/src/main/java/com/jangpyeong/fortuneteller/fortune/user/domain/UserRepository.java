package com.jangpyeong.fortuneteller.domain.user;

import java.util.Optional;

public interface UserRepository {
    Optional<User> findByEmail(String email);

    User save(User user);

    User save(User user);

    User save(User user);
}
