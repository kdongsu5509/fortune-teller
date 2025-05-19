package com.jangpyeong.fortuneteller.infra.v1_infra.user;

import com.jangpyeong.fortuneteller.domain.user.domain.User;
import com.jangpyeong.fortuneteller.domain.user.domain.UserRepository;
import com.jangpyeong.fortuneteller.infra.UserJpaRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class UserRepositoryImpl implements UserRepository {

    private final UserJpaRepository userJpaRepository;

    @Override
    public Optional<User> findByEmail(String email) {
        return userJpaRepository.findByEmail(email);
    }

    @Override
    public User save(User user) {
        return userJpaRepository.save(user);
    }

}
