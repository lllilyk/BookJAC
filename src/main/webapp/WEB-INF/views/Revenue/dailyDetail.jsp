<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/03
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title id="title"><fmt:formatDate value="${settlement.inserted}" pattern="yyyy년 MM월 dd일"/> 정산 상세 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <br>
    <hr>
    <%--  버튼  --%>
    <div class="row">
        <div class="col-md-6">
            <h1><fmt:formatDate value="${settlement.inserted}" pattern="yyyy년 MM월 dd일"/> 상세 내역</h1>
        </div>
        <div class="col-md-6 text-end">
            <c:if test="${!empty cart}">
                <button id="doughnutChartBtn" type="button" class="btn btn-outline-secondary">
                    도넛 차트 보기
                </button>
            </c:if>
            <button id="excelBtn" class="btn btn-outline-secondary">엑셀 다운</button>
            <a href="/Revenue/daily" class="btn btn-outline-secondary">
                돌아가기
            </a>
            <a href="/Revenue/daily" class="btn btn-outline-danger">
                발주하기
            </a>
        </div>
    </div>
    <hr>
    <%--  조회 조건  --%>
    <div class="row">
        <form class="row" id="searchForm" method="get">
            <h5><strong>조회 조건</strong></h5>
            <div class="col">
                <label>조회 순서</label>
                <select id="selectWay" class="form-select" aria-label="Default select example">
                    <option value="0" ${param.selectWay == 0 ? 'selected' : ''}>조회 조건 선택</option>
                    <option value="1" ${param.selectWay == 1 ? 'selected' : ''}>판매 수량 순</option>
                    <option value="2" ${param.selectWay == 2 ? 'selected' : ''}>순이익 순</option>
                    <option value="3" ${param.selectWay == 3 ? 'selected' : ''}>재고 적은 순</option>
                    <option value="4" ${param.selectWay == 4 ? 'selected' : ''}>재고 많은 순</option>
                    <option value="5" ${param.selectWay == 5 ? 'selected' : ''}>책 제목 순</option>
                </select>
            </div>
            <div class="col">
                <label>결제 방식</label>
                <select id="payWay" class="form-select" aria-label="Default select example">
                    <option value="0" ${param.payWay == 0 ? 'selected' : ''}>결제 방식 선택</option>
                    <option value="1" ${param.payWay == 1 ? 'selected' : ''}>현금만</option>
                    <option value="2" ${param.payWay == 2 ? 'selected' : ''}>카드만</option>
                </select>
            </div>
            <div class="col">
                <label>책 검색</label>
                <input class="form-control" type="text" value="${param.title}" id="bookTitle">
            </div>
            <div class="col">
                <input class="form-control d-none" type="text" id="settlementId" value="${param.settlementId}">
            </div>

            <div class="col text-end align-self-end">
                <button type="button" class="btn btn-outline-secondary" id="selectBtn">조회</button>
                <a href="/Revenue/dailyDetail?settlementId=${settlement.id}" class="btn btn-outline-secondary">조건 초기화</a>
            </div>
        </form>
    </div>
    <hr>
    <%--도넛 차트 --%>
    <div class="container d-none w-50" id="doughnutChartBox">
        <div style="width: 400px;">
            <canvas id="doughnutChartCanvas"></canvas>
        </div>
        <br>
    </div>

    <%--  판매 리스트 표  --%>
    <table class="table table-bordered excelTable " id="TableToExport">
        <thead>
        <tr class="table-primary">
            <th colspan="8"><h5><strong>판매 책 정보</strong></h5></th>
        </tr>
        <tr>
            <th scope="col">#</th>
            <th scope="col">판매 책 제목</th>
            <th scope="col">남은 수량</th>
            <th scope="col">판매 수량</th>
            <th scope="col">입고가</th>
            <th scope="col">출고가</th>
            <th scope="col">판매 순이익</th>
            <th scope="col">결제 방법</th>
        </tr>
        </thead>
        <tbody id="soldBookTableBody">
        <c:forEach items="${sales}" var="sales" varStatus="num">
            <tr>
                <td>${num.index + 1}</td>
                <td>${sales.title}</td>
                <td><fmt:formatNumber groupingUsed="true" value="${sales.totalCount}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${sales.soldCount}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${sales.inPrice * sales.soldCount}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${sales.outPrice * sales.soldCount}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${(sales.outPrice * sales.soldCount) - (sales.inPrice * sales.soldCount)}"/></td>
                <td>${sales.pay == 1 ? '현금' : '카드'}</td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot id="soldBookTableFoot">
        <tr>
            <th colspan="3">합계</th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.soldCount}"/></th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.inPrice}"/></th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.outPrice}"/></th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.netIncome}"/></th>
            <th></th>
        </tr>
        </tfoot>
    </table>

    <%--  발주 정보  --%>
    <c:if test="${!empty cart}">
        <table class="table table-bordered excelTable" id="TableToExport1">
            <thead class="orderInfo">
            <tr class="table-danger">
                <th colspan="8"><h5><strong>발주 정보</strong></h5></th>
            </tr>
            <tr>
                <th>#</th>
                <th>책 제목</th>
                <th>개 당 입고 금액</th>
                <th>개 당 판매 금액</th>
                <th>발주 수량</th>
                <th>총 입고 금액</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${cart}" var="cart" varStatus="num">
                <tr>
                    <td>${num.index + 1}</td>
                    <td>${cart.title}</td>
                    <td><fmt:formatNumber groupingUsed="true" value="${cart.inPrice}"/></td>
                    <td><fmt:formatNumber groupingUsed="true" value="${cart.outPrice}"/></td>
                    <td>${cart.bookCount}</td>
                    <td><fmt:formatNumber groupingUsed="true" value="${cart.sumInPrice}"/></td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <th colspan="4">합계</th>
                <th>${sumCart.sumBookCount}</th>
                <th><fmt:formatNumber groupingUsed="true" value="${sumCart.sumInPrice}"/></th>
            </tr>
            </tfoot>
        </table>
    </c:if>

</div>
<%--정산 아이디 : ${settlement.id}, 현금 : ${settlement.cash}, 카드 : ${settlement.card}, 시재금 : ${settlement.vaultCash}, 작성일 : ${settlement.inserted}--%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.min.js" integrity="sha512-mlz/Fs1VtBou2TrUkGzX4VoGvybkD9nkeXWJm3rle0DPHssYYx4j+8kIS15T78ttGfmOjH0lLaBXGcShaVkdkg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"></script>
<script src="https://cdn.sheetjs.com/xlsx-0.20.0/package/dist/xlsx.full.min.js"></script>
<script>
    let label = $("#title").text();
    let orderSum = ${sumCart.sumInPrice};
    let inPriceSum = ${sum.netIncome};
</script>
<script src="/js/revenue/chart.js"></script>
<script src="/js/revenue/excel.js"></script>
<script src="/js/revenue/dailyRevenue.js"></script>


</body>
</html>
