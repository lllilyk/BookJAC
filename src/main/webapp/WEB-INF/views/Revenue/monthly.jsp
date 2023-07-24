<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/06/30
  Time: 2:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>월말 정산 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <br>
    <hr>
    <%--  버튼  --%>
    <div class="row">
        <div class="col-md-6">
            <h1>월별 정산 내역</h1>
        </div>
        <div class="col-md-6 text-end">
            <button id="barChartBtn" type="button" class="btn btn-outline-secondary">
                차트 보기
            </button>
            <a href="/Revenue/daily" class="btn btn-outline-secondary">정산 내역</a>
        </div>
    </div>
    <hr>

    <%--  월말 정산 내역 리스트  --%>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">월</th>
            <th scope="col">수입 금액</th>
            <th scope="col">발주 금액</th>
            <th scope="col">순수익</th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <c:forEach items="${list}" var="list" varStatus="num">
            <tr>
                <th scope="row">${num.index + 1}</th>
                <th scope="row"><fmt:formatDate value="${list.inserted}" type="date" pattern="yyyy년 MM월"/> </th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${list.sumIncome}"/></th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${list.sumOutcome != null ? list.sumOutcome : 0}"/></th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${list.sumNetIncome != null ? list.sumNetIncome : 0}"/></th>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="2">합계</td>
            <td>(현금 매출액 - 시재금) + 카드 매출액</td>
            <td>(발주 총액)</td>
            <td>매대 총액 - 발주 금액</td>
        </tr>
        </tfoot>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
