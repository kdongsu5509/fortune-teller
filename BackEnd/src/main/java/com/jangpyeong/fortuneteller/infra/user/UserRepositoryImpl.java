package com.jangpyeong.fortuneteller.infra.user;

import com.jangpyeong.fortuneteller.domain.user.domain.User;
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
