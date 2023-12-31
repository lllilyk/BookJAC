package com.example.bookjac.controller;

import com.example.bookjac.domain.Member;
import com.example.bookjac.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService service;

    @GetMapping("checkId/{id}")
    @ResponseBody
    public Map<String, Object> checkId(@PathVariable("id") String id) {

        return service.checkId(id);
    }

    @GetMapping("checkEmail/{email}")
    @ResponseBody
    public Map<String, Object> checkEmail(
            @PathVariable("email") String email,
            Authentication authentication) {

        return service.checkEmail(email,authentication);
    }

    @GetMapping("checkPhoneNumber/{phoneNumber}")
    @ResponseBody
    public Map<String, Object> checkPhoneNumber(@PathVariable("phoneNumber") String phoneNumber) {
        return service.checkPhoneNumber(phoneNumber);
    }

    @GetMapping("login")
    @PreAuthorize("isAnonymous()")
    public void loginForm() {

    }

    @GetMapping("signup")
    @PreAuthorize("isAnonymous()")
    public void signupForm() {

    }

    @PostMapping("signup")
    @PreAuthorize("isAnonymous()")
    public String signupProcess(Member member, RedirectAttributes rttr) {

        try {
            service.signup(member);
            rttr.addFlashAttribute("message", "회원 가입이 완료되었습니다.");
            return "redirect:/member/login";
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
    @PreAuthorize("isAuthenticated() and (authentication.name eq #member.id) or hasAuthority('manager')")
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
