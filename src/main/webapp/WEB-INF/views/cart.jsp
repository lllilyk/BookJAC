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
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .row {
            margin: 10px 0px 20px 0px;
        }
       .bottomBtn{
            width:100%;
            margin-top: 30px;
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
                      <h1>발주내역 확인</h1>
                  </div>
                  <div class="col-md-6 text-end">
                      <button type="button" class="btn btn-outline-primary">미리보기</button><%--발주요청내역서 폼으로 연결--%>
                      <%--<button type="button" class="btn btn-outline-secondary">돌아가기</button>--%>
                      <a href="/order/process" class="btn btn-outline-secondary">돌아가기</a>
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
                          <%--알맞은 값으로 변경--%>
                          <td>2023-07-12</td>
                          <td>2023-07-30</td>
                          <td>날개 출판유통</td>
                          <td><sec:authentication property='name'/></td>
                          <%--<sec:authentication var="authentication" property="principal"/>
                          <c:set var="username" value="${authentication.name}" />--%>
                      </tr>
                  </tbody>

              </table>

              <table class="table table-bordered" style="text-align: center">
                  <thead>
                  <tr>
                      <th style="width:50px;">ID</th>
                      <th style="width:350px;">제목</th>
                      <th style="width:120px;">출판사</th>
                      <th style="width:100px;">단가</th>
                      <th style="width:165px;">발주수량</th>
                      <th style="width:100px;">합계</th>
                      <th style="width:70px;">삭제</th>
                  </tr>
                  </thead>
                  <tbody class="table-group-divider">
                  <c:forEach items="${cartInfo}" var="cart" varStatus="cartStatus">
                      <tr>
                          <td id="bookIdText_${cartStatus.index}">${cart.bookId }</td>
                          <td>${cart.title }</td>
                          <td>${cart.publisher }</td>
                          <td>${cart.inPrice }</td>
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
                                      <button class="btn btn-light change"><i class="fa-solid fa-circle-check"></i></button>
                                      </div>
                                  </div>
                              </div>
                          </td>
                          <td>
                              <%--합계 식--%>
                                  <fmt:formatNumber value="${cart.inPrice * cart.bookCount}" pattern="#,### 원" />
                          </td>
                          <td>
                              <button id="btn_cart_${cartStatus.index}" type="button"
                                      class="btn btn-outline-danger btn_delete_cart"> 삭제
                              </button>
                          </td>
                      </tr>
                  </c:forEach>
                  <tr>
                      <td colspan="7">
                          <table class="table mb-0" style="text-align: right">
                              <tbody>
                                <tr>
                                    <td>
                                        총 주문 상품 수량 : 50
                                    </td>
                                </tr>
                              </tbody>
                          </table>
                          <table class="table mb-0" style="text-align: right">
                              <tbody>
                              <tr>
                                  <td>
                                      총 결제 예상 금액  : 500,000
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
                      <%--취소하시겠습니까? 모달 띄우기--%>
                      <button type="button" class="btn btn-secondary">취소하기</button>
                      <button type="button" class="btn btn-danger">발주하기</button>
                  </div>
              </div>
          </div>
      </div>
  </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/order/cart.js"></script>
</body>
</html>

