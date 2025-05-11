package com.jangpyeong.fortuneteller.v2.domain.user;

import java.util.Optional;

public interface UserRepository {
    Optional<User> findByEmail(String email);
    User save(User user);
}
