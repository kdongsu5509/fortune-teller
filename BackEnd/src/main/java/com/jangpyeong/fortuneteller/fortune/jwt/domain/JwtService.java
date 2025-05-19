package com.jangpyeong.fortuneteller.domain.jwt;

import com.jangpyeong.fortuneteller.infra.jwt.JwtUtil;
import com.jangpyeong.fortuneteller.support.properties.JwtProperties;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class JwtService {

    private final JwtUtil jwtUtil;
    private final JwtRepository jwtRepository;
    private final UserDetailsService userDetailsService;
    private final JwtProperties jwtProperties;

    public String ValidAccess(HttpServletRequest request) {
        String accessToken = request.getHeader("Authorization");

        if (accessToken == null || !accessToken.startsWith("Bearer ")) {
            log.warn("accessToken header is missing or malformed");
            return null;
        }
        accessToken = accessToken.replaceFirst("^Bearer\\s+", "").trim();
        log.info("accessToken: {}", accessToken);

        JwtAuthRedis jwtAuth = jwtRepository.findJwtAuthRedisByAccessToken(accessToken).orElse(null);
        if (jwtAuth == null) {
            log.warn("accessToken not found in Redis");
            return null;
        }

        if (!accessToken.equals(jwtAuth.getAccessToken())) {
            log.warn("access token does not match");
            return null;
        }

        if (LocalDateTime.now().isAfter(jwtAuth.getAccessExpiration())) {
            log.warn("accessToken expired");
            return null;
        }

        return accessToken;
    }

    public JwtResult.Issue issueJwtAuth(String userId, String role) {

        String access = jwtUtil.createAccessToken(userId, role);
        String refresh = jwtUtil.createRefreshToken(userId, role);

        JwtAuthRedis findJwtAuth = jwtRepository.findJwtAuthRedisByEmail(userId).orElse(null);

        JwtAuthRedis savedJwt = new JwtAuthRedis();
        savedJwt.setAccessToken(access);
        savedJwt.setRefreshToken(refresh);
        savedJwt.setEmail(userId);
        savedJwt.setAccessExpiration(jwtUtil.getExpirationFromToken(access));
        savedJwt.setRefreshExpiration(jwtUtil.getExpirationFromToken(refresh));

        if (findJwtAuth == null) {
            savedJwt.setId("JWT:" + UUID.randomUUID());
            savedJwt.setCreateAt(LocalDateTime.now());
        } else {
            savedJwt.setId(findJwtAuth.getId());
            savedJwt.setCreateAt(findJwtAuth.getCreateAt());
            savedJwt.setUpdateAt(LocalDateTime.now());
        }

        JwtAuthRedis jwtAuth = jwtRepository.saveOrUpdateJwtAuth(savedJwt);
        Cookie cookie = jwtUtil.createRefreshCookie(refresh);

        return JwtResult.Issue.of(
                jwtAuth.getAccessToken(),
                jwtAuth.getRefreshToken(),
                cookie
        );
    }

    public String reissueAccessByRefresh(HttpServletRequest request) {
        String refreshToken = null;

        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals(jwtProperties.getRefreshCookieName())) {
                    refreshToken = cookie.getValue();
                    break;
                }
            }
        }
        log.info("refrsh Token : {}", refreshToken);

        if (refreshToken == null) {
            log.warn("refresh token not found in header");
            return null;
        }

        JwtAuthRedis jwtAuth = jwtRepository.findJwtAuthRedisByRefreshToken(refreshToken).orElse(null);

        if (jwtAuth == null) {
            log.warn("refresh token not found in redis");
            return null;
        }

        if (!refreshToken.equals(jwtAuth.getRefreshToken())) {
            log.warn("refresh token does not match");
            return null;
        }

        if (jwtAuth.getRefreshExpiration().isBefore(LocalDateTime.now())) {
            log.warn("refresh expired");
            return null;
        }

        String reissueAccessToken = jwtUtil.createAccessToken(
                jwtUtil.getUsername(jwtAuth.getAccessToken()),
                jwtUtil.getRole(jwtAuth.getAccessToken())
        );

        jwtAuth.setAccessToken(reissueAccessToken);
        jwtAuth.setUpdateAt(LocalDateTime.now());
        jwtRepository.saveOrUpdateJwtAuth(jwtAuth);
        log.info("accessUpdate : {}", reissueAccessToken);

        return reissueAccessToken;
    }

    public Authentication getAuthentication(String validAccessToken) {
        String username = jwtUtil.getUsername(validAccessToken);
        UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        return new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
    }

    public List<JwtAuthRedis> getJwtInfoAll() {
        return jwtRepository.findAllJwtAuthRedis();
    }

}
