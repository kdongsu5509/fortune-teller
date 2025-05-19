package com.jangpyeong.fortuneteller.fortune.user.infra;

import com.jangpyeong.fortuneteller.domain.user.User;
import com.jangpyeong.fortuneteller.domain.user.UserRepository;
import com.jangpyeong.fortuneteller.infra.user.UserJpaRepository;
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
