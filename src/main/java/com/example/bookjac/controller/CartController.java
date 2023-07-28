package com.example.bookjac.controller;

import com.example.bookjac.domain.BookResult;
import com.example.bookjac.domain.Cart;
import com.example.bookjac.service.CartService;
import com.example.bookjac.service.NaverBookAPIService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CartController {

    @Autowired
    public CartService cartService;

    private final NaverBookAPIService naverBookAPIService;

    @Autowired
    public CartController(NaverBookAPIService naverBookAPIService) {
        this.naverBookAPIService = naverBookAPIService;
    }

    @ModelAttribute("currentDate")
    public String getCurrentDate() {
        /*현재 날짜를 가져와서 원하는 형식으로 포맷팅*/
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return currentDate.format(formatter);
    }

    @GetMapping("cart/{id}")
    @PreAuthorize("isAuthenticated()")
    public String cartPageGet(@PathVariable("id") String memberId,
                                  Model model,
                                  Authentication auth){

        /* 현재 사용자의 이름(username) 가져오기 */
        String username = auth.getName();

        List<Cart> cart = cartService.getCartList(memberId, username);

        model.addAttribute("cartInfo", cart);
        return "cart";
    }

   @PostMapping("/cart/add")
   @ResponseBody
   public String addCart(@RequestBody Cart cart, Authentication auth) {
       int result = naverBookAPIService.addCart(cart, auth);
       return String.valueOf(result);
   }

    @PostMapping("/cart/update")
    @ResponseBody
    public Map<String, String> updateCart(@RequestBody Cart cart,
                                          Authentication auth,
                                          String username){
        int change = cartService.modifyCount(cart);
        String memberId = auth.getName();

        Cart modified = cartService.getCart(cart.getCartId());

        /* JSON 형식의 응답 데이터 생성 */
        Map<String, String> response = new HashMap<>();
        if(change > 0){
            response.put("result", "success");

            // 총 발주 품목 수량과 총 결제 예상 금액 계산
            List<Cart> cartList = cartService.getCartList(memberId, username);

            int totalQuantity = 0;
            int totalPrice = 0;

            for (Cart c : cartList) {
                totalQuantity += c.getBookCount();
                totalPrice += (c.getInPrice() * c.getBookCount());
            }

            // JSP에 표시되는 총 발주 품목 수량과 총 결제 예상 금액 업데이트
            response.put("totalQuantity", Integer.toString(totalQuantity));
            response.put("totalPrice", Integer.toString(totalPrice));

            // 해당하는 행의 inPriceSum 값을 가져옴
            int inPriceSum = modified.getInPrice() * modified.getBookCount();
            response.put("inPriceSum", Integer.toString(inPriceSum));

        } else{
            response.put("result", "fail");
        }

        return response;
    }

    /* AJAX에 맞게 변경해야 함 */
    @DeleteMapping("/cart/delete/{cartId}")
    @ResponseBody
    public Map<String, String> deleteCart(@PathVariable("cartId") Integer cartId){

        /* cartId에 해당하는 발주 품목 삭제 */
        int delete = cartService.deleteCart(cartId);
        System.out.println(delete);
        /* 응답 */
        Map<String, String> response = new HashMap<>();
        if(delete > 0) {
            response.put("result", "success");
        } else {
            response.put("result", "fail");
        }

        return response;
    }
}
