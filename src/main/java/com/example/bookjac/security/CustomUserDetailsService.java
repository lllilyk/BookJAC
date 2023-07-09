package com.example.bookjac.security;

import com.example.bookjac.domain.Member;
import com.example.bookjac.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private MemberMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Member member = mapper.selectById(username);

        if (member == null) {
            throw new UsernameNotFoundException(username + "회원이 존재하지 않습니다.");
        }

        UserDetails user = User.builder()
                .username(member.getId())
                .password(member.getPassword())
                .authorities(List.of())
                .build();

        return user;
    }
}
