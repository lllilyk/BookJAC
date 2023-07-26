package com.example.bookjac.security;

import com.example.bookjac.domain.Member;
import com.example.bookjac.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

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

        /* 39번째 코드를 풀어 쓴다면
        List<SimpleGrantedAuthority> authorityList = new ArrayList<>();
            for (String auth : member.getAuthority()) {
                authorityList.add(new SimpleGrantedAuthority(auth));
        }
        */

        CustomUser customUser = new CustomUser(member.getId(), member.getPassword(), member.getAuthority().stream().map(SimpleGrantedAuthority::new).toList());
        customUser.setOriginName(member.getName());

        return customUser;
    }
}
