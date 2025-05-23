package com.jangpyeong.fortuneteller.domain.user.domain;

import com.jangpyeong.fortuneteller.common.util.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Table(name = "users")
@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User extends BaseTimeEntity {
    @Id
    @Column(name = "email", length = 99, unique = true, nullable = false)
    @Getter
    private String email;

    @Column(name = "password", length = 99, nullable = false)
    private String password;

    @Column(name = "role", length = 20, nullable = false)
    private String role;

    private User(String email, String password, String role) {
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public static User create(String email, String password, String role) {
        return new User(email, password, role);
    }
}
