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
    <title>전체 발주내역 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <style>
        .row {
            margin: 10px 0px 20px 0px;
        }

        .ui-datepicker-trigger {
            width: 14%;
            height: 50px;
            background-color: white;
            border-radius: 10%;
            border-color: black;
            font-size: 15px;
            cursor:pointer;
        }

        .ui-widget.ui-widget-content{
            /* 전체 박스 */
            border:0px;
            box-shadow: 5px 5px 10px #ccc;
            padding:0;

        }
        .ui-widget-header{
            /* 헤더 (화살표/날짜표시 영역) */
            background: #000;
            border: 0px;
            border-radius: 0px;
        }
        .ui-widget-header .ui-icon{
            /* 이전,다음 화살표 */
            background: none;
        }
        .ui-datepicker-prev{
            /* 이전 화살표 */
            text-align:center;
            line-height: 2em;
        }
        .ui-datepicker-prev::before{
            font: var(--fa-font-solid);
            content:'\f0d9';
            color:#fff;
        }
        .ui-datepicker-next{
            /* 다음 화살표 */
            text-align:center;
            line-height: 2em;
        }
        /*font-awesome 이용해서 화살표 변경*/
        .ui-datepicker-next::before{
            font: var(--fa-font-solid);
            content:'\f0da';
            color:#fff;
        }
        .ui-datepicker .ui-datepicker-title{
            /* 년월 텍스트 묶음 */
            color: #000000;
        }
        .ui-datepicker .ui-datepicker-title .ui-datepicker-year{
            /* 년도 숫자만 */
            color: gold;
            background-color: black;
            border-style: hidden;
        }
        .ui-datepicker .ui-datepicker-title .ui-datepicker-month{
            /* *월 */
            color: gold;
            background-color: black;
            border-style: hidden;
        }
        .ui-datepicker th{
            /* 요일 영역 */
            background : #6e6e6e;
        }
        .ui-datepicker th span{
            /* 요일 텍스트 */
            font-size:18px;
            color: #fff;
        }

        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active{
            /* 일자 기본영역 */
            border:0px;
            background: none;
            text-align: center;
            width: 24px;
            height: 24px;
            line-height: 24px;
            border-radius: 100%;
            padding:0;
            margin: 0 auto;
        }
        .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight{
            /* 오늘일자 */
            border:0px;
            background: #000000;
            color: #fff;
        }
        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover{
            /* 선택 일자 */
            background: gold;
            color: #000;
        }

        .checkDate{
            margin-left: 80px;
            text-align: center;
            width: 250px;
            height: 50px;
            font-weight: bold;
        }
        .bookSearchBar{
            height: 50px;
        }
        .nameSearchContainer {
            padding: 10px;
            border: solid;
            border-color: lightgray;
        }
        .active > .page-link, .page-link.active {
            z-index: 3;
            background-color: black;
            border-color: black;
        }
        .pagination {
            --bs-pagination-color: black;
            --bs-pagination-active-border-color: black;
            --bs-pagination-focus-color: black;
            --bs-pagination-hover-color: black;
        }
        a {
            color: black;
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
                    <h1>전체 발주 내역</h1>
                </div>
            </div>

            <div class="nameSearchContainer container-lg mt-3 mb-4">
                <div class="row g-3">
                <%-- 발주 담당자별 발주내역 검색하기 --%>
                    <div class="col-md-6">
                        <form id="nameSearchForm" action="/order/details">
                            <div class="input-group mb-3">
                                <label for="inputTitle" class="form-label" style="font-size: 20px; font-weight: bold; margin: auto;">발주담당자로 검색</label>
                            </div>
                            <div class="input-group mb-3 bookSearchBar">
                                <input type="search" name="search" class="form-control" id="inputTitle" placeholder="이름을 입력하세요" aria-describedby="bookSearchBtn" style="text-align: center; width:500px; margin-left: 50px;">
                                <button class="btn btn-dark" type="submit" id="bookSearchBtn">검색</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <form id="dateSearchForm" action="/order/details">
                            <div class="input-group mb-3">
                                <label for="searchByDate" class="form-label" style="font-size: 20px; font-weight: bold; margin: auto;">발주일자로 검색</label>
                            </div>
                            <div class="input-group mb-3">
                                <input type="text" id="searchByDate" class="checkDate form-control" autocomplete="off" placeholder="발주일자확인 →" readonly>
                                <button type="submit" class="btn btn-dark dateBtn" >날짜 선택 후 클릭!</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <%--발주 내역 list--%>
            <table class="table table-bordered" style="text-align: center">
                <thead>
                    <tr>
                        <th>발주담당자</th>
                        <th>발주일자</th>
                        <th>수량</th>
                        <th>결제금액</th>
                    </tr>
                </thead>
                <tbody class="table-group-divider">
                    <c:forEach items="${orderDetailsList}" var="od" varStatus="orderDetails">
                        <tr>
                            <td>${od.name}</td>
                            <td><a href="/order/each?inserted=${od.inserted}&memberId=${od.memberId}">${od.inserted}</a></td>
                            <td>${od.totalQuantity}</td>
                            <td>${od.totalPrice}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty orderDetailsList}">
                <p class="text-center">검색 결과가 없습니다.</p>
            </c:if>
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
<%--datepicker--%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/order/details.js"></script>
</body>
</html>
