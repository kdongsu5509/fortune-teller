package com.jangpyeong.fortuneteller.v2.infra.user;

import com.jangpyeong.fortuneteller.v2.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserJpaRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}
