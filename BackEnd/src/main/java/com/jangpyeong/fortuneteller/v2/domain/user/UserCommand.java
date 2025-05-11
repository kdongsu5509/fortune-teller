package com.jangpyeong.fortuneteller.v2.domain.user;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class UserCommand {

    @Getter
    public static class Signup{
        private final String email;
        private final String password;

        private Signup(String email, String password) {
            this.email = email;
            this.password = password;
        }

        public static Signup of(String email, String password) {
            return new Signup(email, password);
        }
    }

}
