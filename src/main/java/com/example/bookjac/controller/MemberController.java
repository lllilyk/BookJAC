package com.example.bookjac.controller;

import com.example.bookjac.domain.Member;
import com.example.bookjac.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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
    @PreAuthorize("isAnonymous()")
    public void signupForm() {

    }

    @GetMapping("login")
    @PreAuthorize("isAnonymous()")
    public void loginForm() {

    }

    @PostMapping("signup")
    @PreAuthorize("isAnonymous()")
    public String signupProcess(Member member, RedirectAttributes rttr) {

        try {
            service.signup(member);
            rttr.addFlashAttribute("message", "회원 가입이 완료되었습니다.");
            return "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("member", member);
            rttr.addFlashAttribute("message", "회원 가입에 실패하였습니다.");
            return "redirect:/member/signup";
        }
    }

    @GetMapping("list")
    @PreAuthorize("hasAuthority('manager')")
    public void list(Model model) {
        List<Member> list = service.listMember();
        model.addAttribute("memberList", list);

    }

    @GetMapping("info")
    @PreAuthorize("(isAuthenticated() and (authentication.name eq #id)) or hasAuthority('manager')")
    public void info(String id, Model model) {
        Member member = service.get(id);
        model.addAttribute("member", member);
    }

    @PostMapping("remove")
    @PreAuthorize("isAuthenticated() and (authentication.name eq #member.id)")
    public String remove(Member member, RedirectAttributes rttr,
                         HttpServletRequest request) throws Exception {

        boolean ok = service.remove(member);

        if (ok) {
            rttr.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");

            // 로그아웃
            request.logout();

            return "redirect:/";
        } else {
            rttr.addFlashAttribute("message","회원 탈퇴에 실패하였습니다.");
            return "redirect:/member/info?id=" + member.getId();

        }
    }

    @GetMapping("modify")
    @PreAuthorize("isAuthenticated() and (authentication.name eq #id)")
    public void modifyForm(String id, Model model) {

        model.addAttribute(service.get(id));
    }

    @PostMapping("modify")
    @PreAuthorize("isAuthenticated() and (authentication.name eq #member.id)")
    public String modifyProcess(Member member, String oldPassword, RedirectAttributes rttr) {
        boolean ok = service.modify(member, oldPassword);

        if(ok) {
            rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
            return "redirect:/member/info?id=" + member.getId();
        } else {
            rttr.addFlashAttribute("message", "회원 정보 수정 시 문제가 발생했습니다.");
            return "redirect:/member/modify?id=" + member.getId();
        }

    }
}
