<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
      integrity="sha512-t4GWSVZO1eC8BM339Xd7Uphw5s17a86tIZIj8qRxhnKub6WoyhnrxeCIMeAqBPgdZGlCcG2PrZjMc+Wr78+5Xg=="
      crossorigin="anonymous" referrerpolicy="no-referrer"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
      crossorigin="anonymous" referrerpolicy="no-referrer"/>


<html>
<head>
    <title>입고 내역</title>
</head>

<style>
    .inboundSellingListContainer {
        padding: 10px;
        border: solid;
        border-color: lightgray;
    }
</style>
<body>

<my:navBar current="/inventory/inboundSellingList"></my:navBar>

<div class="container-lg mt-3">
    <h1><a href="/inventory/inboundSellingList" style="color: black; text-decoration-line: none">입고 내역</a></h1>
    <h6>${dateTime}</h6>
</div>

<%-- search --%>
<form class="inboundSellingListContainer container-lg mt-3 mb-3">
    <label for="inputSearch" class="form-label">검색조건</label>
    <div class="d-flex mb-3">
        <select class="form-select" name="type" id="inputSearch" style="width: 200px">
            <option value="all">전체</option>
            <option value="title" ${param.type eq 'title' ? 'selected' : '' }>제목</option>
            <option value="writer" ${param.type eq 'writer' ? 'selected' : '' }>저자</option>
            <option value="body" ${param.type eq 'body' ? 'selected' : '' }>출판사</option>
        </select>
        <input value="${param.search }" name="search" class="form-control" type="search" placeholder="Search"
               aria-label="inputSearch" for="inputSearch" style="width: 800px">
    </div>

    <label for="inputDate" class="form-label">조회일자</label>
    <div class="d-flex" id="inputDate">
        <div style="margin-right: 20px">
            <input type="date" class="form-control" name="startDate" id="inputStartDate" value="">
        </div>
        <div>
            <input type="date" class="form-control" name="EndDate" id="inputEndDate" value="">
        </div>
        <div class="ms-auto mt-auto">
            <input type="button" class="btn btn-secondary" onclick='location.href="/inventory/inboundSellingList"'
                   value="리셋">
            <button type="submit" class="btn btn-primary">찾기</button>
        </div>
    </div>

</form>

<%-- 입고 리스트 --%>
<div class="container-lg">
    <button id="showInboundBtn" type="button" class="btn btn-danger">입고전만</button>
    <button id="showInboundedBtn" type="button" class="btn btn-success">입고됨만</button>
    <button id="showAllBtn" type="button" class="btn btn-secondary">전체</button>
    <table class="table">
        <thead>
        <tr>
            <th>입고현황</th>
            <th>도서코드</th>
            <th>도서명</th>
            <th>저자</th>
            <th>출판사</th>
            <th>총수량</th>
            <th>입고수</th>
            <th>발주일</th>
            <th>입고일</th>
            <th>발주담당자</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orderList}" var="order" varStatus="loop">
            <tr class="bookRow ${order.inbounded ? 'inbounded' : 'inbound'}">
                <td>
                    <c:if test="${order.inbounded}">
                        <button id="checkInbounded_${order.cartId}_${loop.index}" type="button"
                                class="btn btn-outline-primary btn-sm">입고됨
                        </button>
                    </c:if>
                    <c:if test="${!order.inbounded}">
                        <button id="checkInbound_${order.cartId}_${loop.index}" type="button"
                                class="btn btn-outline-danger btn-sm" onclick="handleInbound(${order.cartId})">
                            입고전
                        </button>
                    </c:if>
                </td>
                <td>${order.bookId}</td>
                <td>${order.title}</td>
                <td>${order.writer}</td>
                <td>${order.publisher}</td>
                <td>
                    <c:if test="${order.inbounded}">
                        <span id="totalCount_${order.cartId}_${loop.index}">${order.totalCount + order.bookCount}</span>
                    </c:if>
                    <c:if test="${!order.inbounded}">
                        ${order.totalCount eq null ? 0 : order.totalCount}
                    </c:if>
                </td>
                <td>${order.bookCount}</td>
                <td>${order.inserted}</td>
                <td id="inboundDate_${order.cartId}_${loop.index}">
                    <c:if test="${order.inboundedDate != null}">
                        ${order.inboundedDate}
                    </c:if>
                </td>
                <td>${order.memberId}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%-- 페이지네이션 --%>
<div class="container-lg">
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">

            <%-- 이전 페이지 --%>
            <li class="page-item">
                <c:if test="${pageInfo.currentPageNum gt 1 }">
                    <c:url value="/inventory/inboundSellingList" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum - 1}"></c:param>
                    </c:url>
                    <a class="page-link" href="${pageLink}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </c:if>
            </li>

            <%-- 페이지 목록--%>
            <c:forEach begin="${pageInfo.page + 1 }" end="${pageInfo.lastPageNum}" var="pageNum">
                <li class="page-item">
                    <c:url value="/inventory/inboundSellingList" var="pageLink">
                        <c:param name="page" value="${pageNum }"></c:param>
                    </c:url>
                    <a class="page-link ${pageNum eq (pageInfo.currentPageNum) ? 'active' : ''}"
                       href="${pageLink }">${pageNum}</a>
                </li>
            </c:forEach>

            <%-- 다음 페이지 --%>
            <li class="page-item">
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                    <c:url value="/inventory/inboundSellingList" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum + 1}"></c:param>
                    </c:url>
                    <a class="page-link" href="${pageLink}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </c:if>
            </li>
        </ul>
    </nav>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js"
        integrity="sha512-3dZ9wIrMMij8rOH7X3kLfXAzwtcHpuYpEgQg1OA4QAob1e81H8ntUQmQm3pBudqIoySO5j0tHN4ENzA6+n2r4w=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
        integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/Inventory/inbound.js"></script>

</body>
</html>
