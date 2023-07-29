<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2023-07-28
  Time: 오후 4:01
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
    <title>발주내역</title>
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
                    <h1>발주 내역</h1>
                </div>
                <div class="col-md-6 text-end">
                    <%--<button type="button" class="btn btn-outline-primary">미리보기</button>
                    <a href="/order/process" class="btn btn-outline-secondary">돌아가기</a>--%>
                </div>
            </div>

            <%-- search --%>
            <input name="search" class="searchBar" type="search" placeholder="검색어를 입력하세요.">
            <button type="submit">검색
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>

            <%--발주 내역 list--%>
            <table class="table table-bordered" style="text-align: center">
                <thead>
                    <tr>
                        <th>발주담당자</th>
                        <th>발주일</th>
                        <th>수량</th>
                        <th>결제금액</th>
                    </tr>
                </thead>
                <tbody class="table-group-divider">
                    <c:forEach items="${orderDetailsList}" var="od" varStatus="orderDetails">
                        <tr>
                            <td><a href="/order/details/${od.id}">${od.name}</a></td>
                            <td><a href="/order/details/${od.id}">${od.inserted}</a></td>
                            <td>${od.totalQuantity}</td>
                            <td>${od.totalPrice}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
                    <c:url value="/order/details" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum -1 }"/>
                    </c:url>
                    <li class="page-item">
                        <a class="page-link" href="${pageLink}">이전</a>
                    </li>
                </c:if>

                <%-- 페이지 영역 --%>
                <c:forEach begin="${pageInfo.leftPageNum}" end="${pageInfo.rightPageNum}" var="pageNum">
                    <c:url value="/order/details" var="pageLink">
                        <c:param name="page" value="${pageNum}"/>
                    </c:url>
                    <li class="page-item">
                        <a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : ''}" href="${pageLink}"> ${pageNum} </a>
                    </li>
                </c:forEach>

                <%-- 다음 버튼--%>
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum}">
                    <c:url value="/order/details" var="pageLink">
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

</body>
</html>
