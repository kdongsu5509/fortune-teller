package com.jangpyeong.fortuneteller.v2.filter.auth;

import com.jangpyeong.fortuneteller.v2.domain.jwt.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;

import static com.jangpyeong.fortuneteller.v2.supprot.util.CommUtils.LOGIN_URL;

@Slf4j
@RequiredArgsConstructor
public class JwtFilter extends OncePerRequestFilter {

    private final JwtService jwtService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.equals(LOGIN_URL)) {
            filterChain.doFilter(request, response);
            return;
        }

        String validAccessToken = jwtService.ValidAccess(request);

        if (validAccessToken == null) {
            validAccessToken = jwtService.reissueAccessByRefresh(request);

            if(validAccessToken == null) {
                filterChain.doFilter(request, response);
                return;
            }
        }

        log.info("JWT valid success : {}", validAccessToken);
        Authentication authentication = jwtService.getAuthentication(validAccessToken);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        filterChain.doFilter(request, response);

    }

}
