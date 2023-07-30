<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2023-07-30
  Time: 오전 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>발주내역 확인 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .row {
            margin: 10px 0px 20px 0px;
        }
    </style>
</head>
<body>
<my:navBar current="orderList"></my:navBar>
<my:alert></my:alert>

<div class="ui center aligned container" id="container">
  <div class="row justify-content-center">
    <div class="col-12">
      <div class="row">
        <div class="col-md-6">
            <h1><sec:authentication property='principal.originName'/>님의 발주 내역</h1>
        </div>
        <div class="col-md-6 text-end">
            <a href="/order/details" class="btn btn-outline-secondary">돌아가기</a>
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
                      <td>${inserted}</td>
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
                  <th style="width:350px;">제목</th>
                  <th style="width:150px;">글쓴이</th>
                  <th style="width:100px;">출판사</th>
                  <th style="width:80px;">단가</th>
                  <th style="width:80px;">발주수량</th>
                  <th style="width:100px;">합계</th>
              </tr>
              </thead>
              <tbody class="table-group-divider">
              <c:forEach items="${orderCartList}" var="oc" >
                  <tr>
                      <td>${oc.bookId }</td>
                      <td>${oc.title }</td>
                      <td>${oc.writer}</td>
                      <td>${oc.publisher }</td>
                      <td><fmt:formatNumber value="${oc.inPrice}" type="currency" currencyCode="KRW" /></td>
                      <td>${oc.bookCount}</td>
                      <td class="inPriceSumEach">
                          <fmt:formatNumber value="${oc.inPrice * oc.bookCount}" type="currency" currencyCode="KRW" />
                      </td>
                  </tr>
                  <!-- totalQuantity와 totalPrice 계산 -->
                  <c:set var="totalQuantity" value="${totalQuantity + oc.bookCount}" />
                  <c:set var="totalPrice" value="${totalPrice + (oc.inPrice * oc.bookCount)}" />
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
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    var date = '${orderCartJson}';
</script>
<script src="/js/order/each.js"></script>
</body>
</html>
