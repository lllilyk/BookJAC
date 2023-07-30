<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2023-07-11
  Time: 오후 3:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>발주품목 확인 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .row {
            margin: 10px 0px 20px 0px;
        }
       .bottomBtn{
            width:100%;
            margin-top: 10px;
        }
       .info {
           margin-top: 20px;
       }
    </style>
</head>
<body>

  <my:navBar current="cart"></my:navBar>
  <my:alert></my:alert>

  <div class="ui center aligned container" id="container">
      <div class="row justify-content-center">
          <div class="col-12">
              <div class="row">
                  <div class="col-md-6">
                      <h1>발주품목 확인</h1>
                  </div>
                  <div class="col-md-6 text-end">
                      <a href="/order/process" class="btn btn-outline-dark">돌아가기</a>
                  </div>
              </div>

              <table class="table table-bordered info" style="text-align: center">
                  <thead>
                      <tr>
                          <th class="table-dark" style="width:150px;">발주일자</th>
                          <th class="table-dark" style="width:150px;">납기일자</th>
                          <th class="table-dark" style="width:150px;">매입처명</th>
                          <th class="table-dark" style="width:150px;">발주담당자</th>
                      </tr>
                  </thead>
                  <tbody class="table-group-divider">
                      <tr>
                          <td>${currentDate}</td>
                          <td id="deadline"></td>
                          <td>날개 출판유통</td>
                          <td><sec:authentication property='principal.originName'/></td>
                      </tr>
                  </tbody>
              </table>

              <c:set var="totalQuantity" value="0" />
              <c:set var="totalPrice" value="0" />
              <table class="table table-bordered" style="text-align: center">
                  <thead>
                      <tr>
                          <th style="width:50px;">ISBN</th>
                          <th style="width:300px;">제목</th>
                          <th style="width:100px;">글쓴이</th>
                          <th style="width:100px;">출판사</th>
                          <th style="width:100px;">단가</th>
                          <th style="width:180px;">발주수량</th>
                          <th style="width:100px;">합계</th>
                          <th style="width:70px;">삭제</th>
                      </tr>
                  </thead>
                  <tbody class="table-group-divider">
                  <c:forEach items="${cartInfo}" var="cart" varStatus="cartStatus">
                      <tr id="cartRow_${cartStatus.index}">
                          <td id="bookIdText_${cartStatus.index}">${cart.bookId }</td>
                          <td>${cart.title }</td>
                          <td>${cart.writer}</td>
                          <td>${cart.publisher }</td>
                          <td><fmt:formatNumber value="${cart.inPrice}" type="currency" currencyCode="KRW" /></td>
                          <td>
                              <div class="btn">
                                  <div class="btn_quantity">
                                      <div class="input-group">
                                          <button id="minus_btn_${cartStatus.index}" type="button"
                                                  class="btn btn-light minus_btn">-
                                          </button>
                                          <input id="quantity_input_${cartStatus.index}" type="text"
                                                 class="form-control quantity_input" value="${cart.bookCount}"
                                                 style="width:55px; text-align: center">

                                          <button id="plus_btn_${cartStatus.index}" type="button"
                                                  class="btn btn-light plus_btn">+
                                          </button>
                                          <button class="btn btn-light changeBtn" id="btn_cart_${cartStatus.index}" value="${cart.cartId}">
                                                <i class="fa-solid fa-circle-check"></i>
                                          </button>
                                      </div>
                                  </div>
                              </div>
                          </td>
                          <td class="inPriceSumEach" id="inPriceSum_${cartStatus.index}">
                              <fmt:formatNumber value="${cart.inPrice * cart.bookCount}" type="currency" currencyCode="KRW" />
                          </td>
                          <td>
                              <button id="btn_cart_${cartStatus.index}" type="button"
                                      class="btn btn-outline-danger btn_delete_cart"> 삭제
                              </button>
                          </td>
                      </tr>
                      <!-- totalQuantity와 totalPrice 계산 -->
                      <c:set var="totalQuantity" value="${totalQuantity + cart.bookCount}" />
                      <c:set var="totalPrice" value="${totalPrice + (cart.inPrice * cart.bookCount)}" />
                  </c:forEach>
                  <tr>
                      <td colspan="8">
                          <table class="table mb-0" style="text-align: right">
                              <tbody>
                                <tr>
                                    <td id="totalQuantity">
                                        총 발주 수량 : <fmt:formatNumber value="${totalQuantity}" />
                                    </td>
                                </tr>
                              </tbody>
                          </table>
                          <table class="table mb-0" style="text-align: right">
                              <tbody>
                              <tr>
                                  <td id="totalPrice">
                                      총 결제 예상 금액  : <fmt:formatNumber value="${totalPrice}" type="currency" currencyCode="KRW" />
                                  </td>
                              </tr>
                              </tbody>
                          </table>
                      </td>
                  </tr>
                  </tbody>
              </table>
              <div class="row">
                  <div class="col-md-6 text-center bottomBtn">
                      <button type="button" class="btn btn-danger addOrderDetails" style="font-size: 18px;">발주하기</button>
                  </div>
              </div>

              <%--modal--%>
              <div class="orderConfirmModal modal" tabindex="-1">
                  <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                              <h5 class="modal-title">발주 확인</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                              <form id="orderProcessForm" action="/order/add" method="post" >
                                  <input type="hidden" name="name" value="<sec:authentication property='principal.originName'/>">
                                  <input type="hidden" name="inserted" value="${currentDate}">
                                  <input type="hidden" name="totalQuantity" value="<fmt:formatNumber value='${totalQuantity}' />">
                                  <input type="hidden" name="totalPrice" value="<fmt:formatNumber value='${totalPrice}' type='currency' currencyCode='KRW' />">
                              </form>
                              <p>발주 품목과 수량이 맞는지 다시 한번 확인해 주세요.</p>
                          </div>
                          <div class="modal-footer">
                              <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">다시 확인할래요</button>
                              <button type="submit" form="orderProcessForm" class="btn btn-outline-danger addOrderDetailsBtn">이대로 발주할게요</button>
                          </div>
                      </div>
                  </div>
              </div>

              <!-- 수량 조정 form -->
              <form action="/cart/update" method="post" class="quantity_update_form">
                  <input type="hidden" name="cartId" class="update_cartId">
                  <input type="hidden" name="bookCount" class="update_bookCount">
              </form>

              <!-- 발주 품목 삭제 form -->
              <form action="/cart/delete" method="post" class="quantity_delete_form">
                  <input type="hidden" name="cartId" class="delete_cartId">
                  <input type="hidden" name="memberId" value="${member.memberId}">
              </form>

          </div>
      </div>
  </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

  <script>
    var currentDate = '${currentDate}';
  </script>
  <script src="/js/order/cart.js"></script>
</body>
</html>

