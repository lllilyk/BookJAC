package com.example.bookjac.service;

import com.example.bookjac.domain.Member;
import com.example.bookjac.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberService {

    @Autowired
    private MemberMapper mapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean signup(Member member) {
        // 비밀번호 암호화
        String plain = member.getPassword();
        member.setPassword(passwordEncoder.encode(plain));

        int cnt = mapper.insert(member);
        return cnt == 1;
    }

    public List<Member> listMember() {

        return mapper.selectAll();
    }

    public Member get(String id) {

        return mapper.selectById(id);
    }

    public boolean remove(Member member) {
        Member oldMember = mapper.selectById(member.getId());
        int cnt = 0;

        if (passwordEncoder.matches(member.getPassword(), oldMember.getPassword())) {
            // 암호가 같으면?

            // 회원이 작성한 게시물 삭제

            // 회원 테이블 삭제
            cnt = mapper.deleteById(member.getId());

        }
        return cnt == 1;
    }

    public boolean modify(Member member, String oldPassword) {
        // 패스워드를 바꾸기 위해 입력했다면
        if (!member.getPassword().isBlank()) {
            // 입력된 패스워드를 암호화
            String plain = member.getPassword();
            member.setPassword(passwordEncoder.encode(plain));
        }

        Member oldMember = mapper.selectById(member.getId());

        int cnt = 0;
        if(passwordEncoder.matches(oldPassword, oldMember.getPassword())) {
            // 기존 암호와 같으면
            cnt = mapper.update(member);
        }
        return cnt == 1;
    }

    public Map<String, Object> checkId(String id) {
        Member member = mapper.selectById(id);

        // member가 null이면 available
        return Map.of("available", member == null);
    }

    public Map<String, Object> checkEmail(String email) {
        Member member = mapper.selectByEmail(email);

        return Map.of("available", member == null);
    }

    public Map<String, Object> checkPhoneNumber(String phoneNumber) {
        Member member = mapper.selectByPhoneNumber(phoneNumber);

        return Map.of("available", member == null);
    }
}

