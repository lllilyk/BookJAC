package com.example.bookjac.controller;

import com.example.bookjac.domain.Member;
import com.example.bookjac.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService service;

    @GetMapping("signup")
    public void signupForm() {

    }

    @PostMapping("signup")
    public String signupProcess(Member member, RedirectAttributes rttr) {

        try {
            service.signup(member);
            rttr.addFlashAttribute("message", "회원 가입이 완료되었습니다.");
            return "redirect:/list";
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("member", member);
            rttr.addFlashAttribute("message", "회원 가입에 실패하였습니다.");
            return "redirect:/member/signup";
        }
    }

    @GetMapping("list")
    public void list(Model model) {
        List<Member> list = service.listMember();
        model.addAttribute("memberList", list);

    }

    @GetMapping("info")
    public void info(String id, Model model) {
        Member member = service.get(id);
        model.addAttribute("member", member);
    }

    @PostMapping("remove")
    public void remove(String id) {
        service.remove(id);
    }
}
