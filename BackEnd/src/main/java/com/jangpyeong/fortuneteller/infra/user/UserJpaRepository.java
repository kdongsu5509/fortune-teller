package com.jangpyeong.fortuneteller.infra.user;

import com.jangpyeong.fortuneteller.domain.user.domain.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserJpaRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}
