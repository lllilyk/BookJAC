package com.example.bookjac.mapper;

import com.example.bookjac.domain.Cart;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CartMapper {

    /* 발주 품목 추가 */
    public int addCart(Cart cart) throws Exception;

    /* 발주 품목 삭제 */
    public int deleteCart(int cartId);

    /* 발주 수량 변경 */
    public int modifyCount(Cart cart);

    /* 발주 품목 List*/
    public List<Cart> getCart(String memberId);

    /* 발주 확인 */
    public Cart checkCart(Cart cart);
}
