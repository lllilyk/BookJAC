<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/06/30
  Time: 11:43 AM
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
    <title>일일 정산 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<my:alert></my:alert>
<div class="container">
    <br>
    <hr>
    <div class="row">
        <div class="col-md-6">
            <h1>일일 정산 내역</h1>
        </div>
        <div class="col-md-6 text-end">
            <button id="addBtn" type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addRevenueModal">
                정산 입력
            </button>
            <a href="/Revenue/monthly" class="btn btn-outline-success">월말 정산</a>
        </div>
    </div>
    <br>
    <%--  조회 조건  --%>
    <form action="/Revenue/daily" class="row justify-content-start">
        <h5>조회 조건</h5>
        <div style="width: 200px;">
            <input class="form-control" type="date" name="startDate" value="${param.startDate}">
        </div>
        <div style="width: 200px;">
            <input class="form-control" type="date" name="endDate" value="${param.endDate}">
        </div>
        <div style="width: 170px;">
            <select name="selectWay" class="form-select col-4" aria-label="Default select example">
                <option value="0" ${param.selectWay == 0 ? 'selected' : ''}>조회 조건 선택</option>
                <option value="1" ${param.selectWay == 1 ? 'selected' : ''}>현금 매출 순</option>
                <option value="2" ${param.selectWay == 2 ? 'selected' : ''}>카드 매출 순</option>
                <option value="3" ${param.selectWay == 3 ? 'selected' : ''}>순수익 순</option>
            </select>
        </div>
        <button style="width: 55px; margin-right: 5px;" type="submit" class="btn btn-outline-primary">조회</button>
        <a style="width: 100px;" href="/Revenue/daily" class="btn btn-outline-primary">조건 초기화</a>
    </form>
    <%-- 일일 정산 리스트 --%>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">매출 일자<small style="color: gray">(입력 시간)</small></th>
            <th scope="col">현금 총액</th>
            <th scope="col">카드 매출액</th>
            <th scope="col">시재금</th>
            <th scope="col">수입내역</th>
            <th scope="col">순수익</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <c:forEach items="${list }" var="settlement">
            <tr id="dailyRow${settlement.id}">
                <th scope="row">${settlement.id }</th>
                <th scope="row">
                    <a href="/Revenue/dailyDetail?settlementId=${settlement.id}">
                        <fmt:formatDate value="${settlement.inserted}" type="date"/>
                    </a>
                    <small style="color: gray">(<fmt:formatDate value="${settlement.inserted}" type="time"/>)</small>
                </th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${settlement.cash}"/></th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${settlement.card}"/></th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${settlement.vaultCash}"/></th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value="${settlement.cash - settlement.vaultCash + settlement.card}"/></th>
                <th scope="row"><fmt:formatNumber groupingUsed="true" value=""/>수입내역 - 판 책 원가</th>
                <th scope="row">
                    <div class="btn-group" role="group" aria-label="Basic outlined example">
                        <button type="button" settlement-id="${settlement.id}" class="btn btn-outline-secondary modifyBtn" data-bs-toggle="modal" data-bs-target="#modifyRevenueModal">
                            수정
                        </button>
                        <button type="button" settlement-id="${settlement.id}" class="btn btn-outline-secondary deleteBtn" data-bs-toggle="modal" data-bs-target="#deleteRevenueModal">
                            삭제
                        </button>
                    </div>
                </th>
            </tr>
        </c:forEach>

        <!-- 없앨 코드 -->
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
<div class="modal fade" id="addRevenueModal" tabindex="-1" aria-labelledby="addRevenueModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="addRevenueModalLabel"><span id="todayBox"></span> 정산 입력</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/Revenue/addDaily" id="addRevenueForm" method="post">
                    <div class="mb-3">
                        <label for="addCash" class="col-form-label">cash drawer : </label>
                        <input type="text" name="cash" class="form-control" id="addCash" value="0">
                    </div>
                    <div class="mb-3">
                        <label for="addCard" class="col-form-label">카드 매출액 : </label>
                        <input type="text" name="card" class="form-control" id="addCard" value="0">
                    </div>
                    <div class="mb-3">
                        <label for="addVaultCash" class="col-form-label">시재금 : </label>
                        <input type="text" name="vaultCash" class="form-control" id="addVaultCash" value="0">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" form="addRevenueForm" id="revenueBtn">정산 입력</button>
            </div>
        </div>
    </div>
</div>

<!-- 정산 수정 폼 모달 -->
<div class="modal fade" id="modifyRevenueModal" tabindex="-1" aria-labelledby="modifyRevenueModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modifyRevenueModalLabel"><span id="modifyDayBox">(수정 날짜)</span> 정산 수정</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="text" class="form-control d-none" id="modifyId">
                <div class="mb-3">
                    <label for="modifyCash" class="col-form-label">현금 매출액 : </label>
                    <input type="text" name="cash" class="form-control" id="modifyCash">
                </div>
                <div class="mb-3">
                    <label for="modifyCard" class="col-form-label">카드 매출액 : </label>
                    <input type="text" name="card" class="form-control" id="modifyCard">
                </div>
                <div class="mb-3">
                    <label for="modifyVaultCash" class="col-form-label">시재금 : </label>
                    <input type="text" name="vaultCash" class="form-control" id="modifyVaultCash">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="modifyModalBtn">정산 수정</button>
            </div>
        </div>
    </div>
</div>

<!-- 정산 삭제 폼 모달 -->
<div class="modal fade" id="deleteRevenueModal" tabindex="-1" aria-labelledby="deleteRevenueModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteRevenueModalLabel">(삭제 날짜) 정산 삭제</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                정산 내역을 삭제하시겠습니까?
                <input type="text" name="id" class="form-control" id="settlementIdInput">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="deleteModalBtn" data-bs-dismiss="modal">정산 삭제</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/revenue/revenue.js"></script>
</body>
</html>
