package com.example.bookjac.config;

import org.eclipse.tags.shaded.org.apache.regexp.RE;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.client.RestTemplate;

@Configuration
@EnableMethodSecurity
public class CustomConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(d -> d.disable());

        // 기본 제공 로그인 폼
        //http.formLogin(Customizer.withDefaults());
        // 직접 만든 로그인 폼 사용
        http.formLogin().loginPage("/member/login");
        http.logout().logoutUrl("/member/logout");

        http.authorizeHttpRequests(r -> r.anyRequest().permitAll());

        return http.build();
    }
}
