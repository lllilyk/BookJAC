<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2023-07-03
  Time: 오전 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <style>
        .row {
            margin: 10px 0px 20px 0px;
        }

        .ui-datepicker-trigger {
            margin-left: 5px;
            width: 14%;
            height: 38px;
            background-color: white;
            border-radius: 10%;
            border-color: gold;
            font-size: 15px;
            cursor:pointer;
        }

        .checkDate{
            text-align: center;
            width: 150px;
            height: 35px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<my:navBar current="orderProcess"></my:navBar>
<my:alert></my:alert>

<div class="ui center aligned container" id="container">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="row">
                <div class="col-md-6">
                    <h1>발주내역 등록</h1>
                </div>
                <div class="col-md-6 text-end">
                    <input type="text" class="checkDate" autocomplete="off" placeholder="발주일자확인 →" readonly>
                    <button type="button" class="btn btn-outline-primary">주문내역조회</button>
                    <a href="/cart/<sec:authentication property='name'/>" class="btn btn-outline-success">발주품목</a>
                </div>
            </div>
            <%--네이버 오픈 API를 활용한 도서 검색--%>
            <div class="container">
                <form id="bookSearchForm" method="get">
                    <div class="input-group mb-3">
                        <input type="text" id="searchBook" class="form-control" placeholder="원하시는 도서명을 입력하세요" aria-describedby="bookSearchBtn">
                        <button class="btn btn-outline-secondary" type="submit" id="bookSearchBtn">검색</button>
                    </div>
                </form>
            </div>

            <%--재고 목록--%>
            <table class="table table-bordered" style="text-align: center">
                <thead>
                <tr>
                    <th style="width:50px;">ISBN</th>
                    <th style="width:350px;">제목</th>
                    <th style="width:170px;">글쓴이</th>
                    <th style="width:170px;">출판사</th>
                    <th style="width:100px;">단가</th>
                    <th style="width:100px;">재고수량</th>
                    <th style="width:165px;">발주수량</th>
                    <th style="width:70px;">발주</th>
                </tr>
                </thead>
                <tbody class="table-group-divider">
                <c:forEach items="${bookList}" var="book" varStatus="bookStatus">
                    <tr>
                        <td class="bookId" id="bookIdText_${bookStatus.index}">${book.id }</td>
                        <td class="title">${book.title }</td>
                        <td>${book.writer }</td>
                        <td class="publisher">${book.publisher }</td>
                        <td class="inPrice"><fmt:formatNumber value="${book.inPrice}" type="currency" currencyCode="KRW" /></td>
                        <td>${book.totalCount }</td>
                        <td>
                            <div class="btn">
                                <div class="btn_quantity">
                                    <div class="input-group">
                                        <button id="minus_btn_${bookStatus.index}" type="button"
                                                class="btn btn-light minus_btn">-
                                        </button>
                                        <input id="quantity_input_${bookStatus.index}" type="text"
                                               class="form-control quantity_input" value="1"
                                               style="width:55px; text-align: center">
                                        <button id="plus_btn_${bookStatus.index}" type="button"
                                                class="btn btn-light plus_btn">+
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <button id="btn_cart_${bookStatus.index}" type="button"
                                    class="btn btn-outline-danger btn_cart"> 등록
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <%--<button class="btn btn-danger" onclick="requestPay()">결제하기</button>--%>
    </div>
</div>
</div>

<%-- pagination --%>
<div class="container-lg">
    <div class="row">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <%-- 이전 버튼 --%>
                <c:if test="${pageInfo.currentPageNum ne 1 }">
                    <c:url value="/order/process" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum -1 }"/>
                    </c:url>
                    <li class="page-item">
                        <a class="page-link" href="${pageLink}">이전</a>
                    </li>
                </c:if>

                <%-- 페이지 영역 --%>
                <c:forEach begin="${pageInfo.leftPageNum}" end="${pageInfo.rightPageNum}" var="pageNum">
                    <c:url value="/order/process" var="pageLink">
                        <c:param name="page" value="${pageNum}"/>
                    </c:url>
                    <li class="page-item">
                        <a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : ''}" href="${pageLink}"> ${pageNum} </a>
                    </li>
                </c:forEach>

                <%-- 다음 버튼--%>
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum}">
                    <c:url value="/order/process" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum + 1}"/>
                    </c:url>
                    <li class="page-item">
                        <a class="page-link" href="${pageLink}">다음</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--datepicker--%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/order/cart.js"></script>
</body>
</html>
