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
    <title id="title">정산 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<my:alert></my:alert>
<div class="container">
    <br>
    <hr>
    <div class="row">
        <div class="col-md-6">
            <h1>정산 내역</h1>
        </div>
        <div class="col-md-6 text-end">
            <button id="barChartBtn" type="button" class="btn btn-outline-secondary">
                차트 보기
            </button>
            <a href="/Revenue/monthly" class="btn btn-outline-secondary">월별 정산</a>
            <button id="excelBtn" class="btn btn-outline-secondary">엑셀 다운</button>
            <button id="addBtn" type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#addRevenueModal">
                정산 입력
            </button>
        </div>
    </div>
    <hr>

    <%--  조회 조건  --%>
    <div class="row">
        <form action="/Revenue/daily" class="row" id="searchForm">
            <h5><strong>조회 조건</strong></h5>
            <div class="col">
                <label for="startDateInput">시작일</label>
                <input class="form-control" type="date" id="startDateInput" name="startDate" value="${param.startDate}">
            </div>
            <div class="col">
                <label for="endDateInput">종료일</label>
                <input class="form-control" type="date" id="endDateInput" name="endDate" value="${param.endDate}">
            </div>
            <div class="col">
                <label for="monthInput">월 별 조회</label>
                <input class="form-control" type="month" id="monthInput" name="month" value="${param.month}">
            </div>
            <div class="col">
                <label>조회 순서</label>
                <select name="selectWay" class="form-select" aria-label="Default select example">
                    <option value="0" ${param.selectWay == 0 ? 'selected' : ''}>조회 조건 선택</option>
                    <option value="1" ${param.selectWay == 1 ? 'selected' : ''}>현금 매출 순</option>
                    <option value="2" ${param.selectWay == 2 ? 'selected' : ''}>카드 매출 순</option>
                    <option value="3" ${param.selectWay == 3 ? 'selected' : ''}>수입내역 순</option>
                </select>
            </div>
            <div class="col text-end align-self-end">
                <button form="searchForm" type="submit" class="btn btn-outline-secondary" id="selectWayBtn">조회</button>
                <a href="/Revenue/daily" class="btn btn-outline-secondary">조건 초기화</a>
            </div>
        </form>
    </div>
    <hr>

    <%--차트--%>
    <div class="container d-none w-50" id="barChartBox">
        <h1>
            수입 차트
            <span id="chartSelectWay" select-way="${param.selectWay}"></span>
        </h1>
        <div>
            <canvas id="barChartCanvas"></canvas>
        </div>
        <br>
    </div>

    <%-- 일일 정산 리스트 --%>
    <table class="table table-bordered" id="TableToExport">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col" class="${param.selectWay == null ? 'text-danger' : ''}">매출 일자<small style="color: gray">(입력 시간)</small></th>
            <th scope="col">시재금</th>
            <th scope="col" class="${param.selectWay == 1 ? 'text-danger' : ''}">cash drawer</th>
            <th scope="col" class="${param.selectWay == 2 ? 'text-danger' : ''}">카드 매출액</th>
            <th scope="col" class="${param.selectWay == 3 ? 'text-danger' : ''}">수입내역</th>
            <th scope="col">순수익</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <c:forEach items="${list }" var="settlement" varStatus="num">
            <tr id="dailyRow${settlement.id}">
                <td>${num.index + 1 }</td>
                <td>
                    <a href="/Revenue/dailyDetail?settlementId=${settlement.id}" id="dateLink${settlement.id }" class="dateInfo">
                        <fmt:formatDate value="${settlement.inserted}" type="date" pattern="yyyy년 MM월 dd일"/>
                    </a>
                    <small style="color: gray">(<fmt:formatDate value="${settlement.inserted}" type="time"/>)</small>
                </td>
                <td><fmt:formatNumber groupingUsed="true" value="${settlement.vaultCash}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${settlement.cash}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${settlement.card}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value="${settlement.cash - settlement.vaultCash + settlement.card}"/></td>
                <td><fmt:formatNumber groupingUsed="true" value=""/>수입내역 - 판 책 원가</td>
                <td>
                    <div class="btn-group" role="group" aria-label="Basic outlined example">
                        <button type="button" settlement-id="${settlement.id}" class="btn btn-outline-secondary modifyBtn" data-bs-toggle="modal" data-bs-target="#modifyRevenueModal">
                            수정
                        </button>
                        <button type="button" settlement-id="${settlement.id}" class="btn btn-outline-secondary deleteBtn" data-bs-toggle="modal" data-bs-target="#deleteRevenueModal">
                            삭제
                        </button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="3">합계</th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.sumCash}"/></th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.sumCard}"/></th>
            <th><fmt:formatNumber groupingUsed="true" value="${sum.sumIncome}"/></th>
            <th>(순수익 총액)</th>
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
                <h1 class="modal-title fs-5" id="modifyRevenueModalLabel"><span id="modifyDayBox"></span> 정산 수정</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="text" class="form-control d-none" id="modifyId">
                <div class="mb-3">
                    <label for="modifyCash" class="col-form-label">현금 매출액 : </label>
                    <input type="text" class="form-control" id="modifyCash">
                </div>
                <div class="mb-3">
                    <label for="modifyCard" class="col-form-label">카드 매출액 : </label>
                    <input type="text" class="form-control" id="modifyCard">
                </div>
                <div class="mb-3">
                    <label for="modifyVaultCash" class="col-form-label">시재금 : </label>
                    <input type="text" class="form-control" id="modifyVaultCash">
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
                <h1 class="modal-title fs-5" id="deleteRevenueModalLabel"><span id="deleteDayBox"></span> 정산 삭제</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                정산 내역을 삭제하시겠습니까?
                <input type="text" class="form-control" id="settlementIdInput">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="deleteModalBtn" data-bs-dismiss="modal">정산 삭제</button>
            </div>
        </div>
    </div>
</div>

<script>
    // 차트 x축 개수 = 배열 길이, 차트의 기본 정보
    let date = new Array();
    let revenueValue = new Array();
    <c:forEach items="${list}" var="settlement" varStatus="num">
    date[${num.index}] = '<fmt:formatDate value="${settlement.inserted}" type="date" pattern="MM/dd"/>';
    revenueValue[${num.index}] = ${settlement.cash - settlement.vaultCash + settlement.card};
    </c:forEach>
    //해당 날짜의 수입내역을 행렬로 넣음
    let xInfo = [date, revenueValue];
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.min.js" integrity="sha512-mlz/Fs1VtBou2TrUkGzX4VoGvybkD9nkeXWJm3rle0DPHssYYx4j+8kIS15T78ttGfmOjH0lLaBXGcShaVkdkg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"></script>
<script src="https://cdn.sheetjs.com/xlsx-0.20.0/package/dist/xlsx.full.min.js"></script>
<script src="/js/revenue/revenue.js"></script>
<script src="/js/revenue/chart.js"></script>
<script src="/js/revenue/excel.js"></script>
</body>
</html>
