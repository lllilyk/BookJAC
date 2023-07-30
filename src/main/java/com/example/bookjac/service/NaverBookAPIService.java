package com.example.bookjac.service;

import com.example.bookjac.domain.BookResult;
import com.example.bookjac.domain.Cart;
import com.example.bookjac.domain.NaverResult;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.Collections;
import java.util.List;

@Service
public class NaverBookAPIService {

    /*네이버 검색 API*/
    @Value("${clientId}")
    private String clientId;

    @Value("${clientSecret}")
    private String clientSecret;

    @Autowired
    private CartService cartService;

    private final RestTemplate restTemplate;

    @Autowired
    public NaverBookAPIService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    /*네이버 API 호출을 위한 URL 생성*/
    public List<BookResult> searchBooks(String text, Authentication auth) {
        String memberId = auth.getName();
        String apiUrl = "https://openapi.naver.com/v1/search/book.json";
        /*쿼리 파라미터로 검색어 설정*/
        URI uri = UriComponentsBuilder.fromUriString(apiUrl)
                .queryParam("query", text)
                .queryParam("display", 10)
                .queryParam("start", 1)
                .queryParam("sort", "sim")
                .encode()
                .build()
                .toUri();

        /*네이버 API 호출을 위한 HTTP 헤더 설정*/
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.add("X-Naver-Client-Id", clientId);
        headers.add("X-Naver-Client-Secret", clientSecret);

        /* 네이버 API 호출 실행 */
        RequestEntity<Void> requestEntity = RequestEntity.get(uri)
                                                         .headers(headers)
                                                         .build();
        ResponseEntity<String> responseEntity = restTemplate.exchange(requestEntity, String.class);


        /*JSON 파싱 (Json 문자열을 객체로 만듦, 문서화)*/
        ObjectMapper om = new ObjectMapper();
        NaverResult result = null;

        try {
            result = om.readValue(responseEntity.getBody(), NaverResult.class);
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return result != null ? result.getItems() : Collections.emptyList();
    }

    public int addCart(Cart cart, Authentication auth) {
        String memberId = auth.getName();
        cart.setMemberId(memberId);

        Cart cartData = new Cart();
        cartData.setMemberId(memberId);
        cartData.setTitle(cart.getTitle());
        cartData.setWriter(cart.getWriter());
        cartData.setPublisher(cart.getPublisher());
        cartData.setInPrice(cart.getInPrice());
        cartData.setBookCount(cart.getBookCount());
        cartData.setBookId(cart.getBookId());
        System.out.println("service : " + cartData);
        // 발주 품목 추가
        int result = cartService.addCart(cartData);
        return result;
    }


}