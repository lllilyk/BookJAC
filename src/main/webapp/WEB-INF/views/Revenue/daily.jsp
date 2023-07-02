<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/06/30
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>일일 정산 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <c:forEach begin="1" end="3">
        ${test}
    </c:forEach>
    <h1>일일 정산 내역</h1>

    <!-- 정산 입력 폼 모달 버튼 -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#revenueInputModal">
        정산 입력
    </button>

    <%-- 월말 정산 버튼 --%>
    <a href="/Revenue/monthly">월말 정산</a>

    <%-- 일일 정산 리스트 --%>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">매출 일자</th>
            <th scope="col">현금 총액</th>
            <th scope="col">카드 매출액</th>
            <th scope="col">시재금</th>
            <th scope="col">수입내역</th>
            <th scope="col">순수익</th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <c:forEach items="${settlement }" var="settlement">
            <tr>
                <th scope="row">${settlement.id }</th>
                <th scope="row">${settlement.inserted }</th>
                <th scope="row">돈통 총액</th>
                <th scope="row">실제 매출액</th>
                <th scope="row">돈통 기본돈</th>
                <th scope="row">(현금 총액 - 시재금) + 카드 매출액</th>
                <th scope="row">수입내역 - 판 책 원가</th>
            </tr>
        </c:forEach>
        <tr>
            <th scope="row">id값</th>
            <th scope="row">2023-02-03</th>
            <th scope="row">돈통 총액</th>
            <th scope="row">실제 매출액</th>
            <th scope="row">돈통 기본돈</th>
            <th scope="row">(현금 총액 - 시재금) + 카드 매출액</th>
            <th scope="row">수입내역 - 판 책 원가</th>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="2">합계</td>
            <td>(현금 총액)</td>
            <td>(카드 총액)</td>
            <td>(시재금 빈칸)</td>
            <td>(수입내역 총액)</td>
            <td>(순수익 총액)</td>
        </tr>
        </tfoot>
    </table>


</div>
<!-- 정산 입력 폼 모달 -->
<div class="modal fade" id="revenueInputModal" tabindex="-1" aria-labelledby="revenueInputModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="revenueInputModalLabel">(오늘 날짜) 정산 입력</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/Revenue/daily" id="RevenueInputForm" method="post">
                    <div class="mb-3">
                        <label for="cashRevenue" class="col-form-label">현금 매출액 : </label>
                        <input type="text" name="cash" class="form-control" id="cashRevenue">
                    </div>
                    <div class="mb-3">
                        <label for="cardRevenue" class="col-form-label">카드 매출액 : </label>
                        <input type="text" name="card" class="form-control" id="cardRevenue">
                    </div>
                    <div class="mb-3">
                        <label for="vaultCash" class="col-form-label">시재금 : </label>
                        <input type="text" name="vaultCash" class="form-control" id="vaultCash">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" form="RevenueInputForm" id="revenueBtn">정산 입력</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>
