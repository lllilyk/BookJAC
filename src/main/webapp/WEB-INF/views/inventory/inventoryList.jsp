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
    <title>재고 목록</title>
</head>

<style>
    .inventoryListContainer {
        padding: 10px;
        border: solid;
        border-color: lightgray;
    }
</style>
<body>

<my:navBar current="/inventory/inventoryList"></my:navBar>

<div style="justify-content: center">

    <div class="container-lg mt-3">
        <h1><a href="/inventory/inventoryList" style="color: black; text-decoration-line: none">재고 목록</a></h1>
        <h6>${dateTime}</h6>
    </div>

    <%-- search --%>
    <form class="inventoryListContainer container-lg mt-3 mb-3">
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
                <input type="button" class="btn btn-secondary" onclick='location.href="/inventory/inventoryList"'
                       value="리셋">
                <button type="submit" class="btn btn-primary">찾기</button>
            </div>
        </div>

    </form>

    <div class="container-lg">
        <table class="table">
            <thead>
            <tr>
                <th>도서코드</th>
                <th>도서명</th>
                <th>저자</th>
                <th>출판사</th>
                <th>매대수량</th>
                <th>창고수량</th>
                <th>총수량</th>
                <th>안전매대수량</th>
                <th>매대디스플레이필요</th>
                <th>안전창고수량</th>
                <th>주문필요</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${inventoryList}" var="inven">
                <tr>
                    <td>${inven.isbn}</td>
                    <td>${inven.title}</td>
                    <td>${inven.writer}</td>
                    <td>${inven.publisher}</td>
                    <td>${inven.displayCount}</td>
                    <td>${inven.inCount}</td>
                    <td>${inven.totalCount}</td>
                    <td>
                        <input name="safeDisplayCount" value="1" class="form-control" type="number" style="width: 80px">
                    </td>
                    <td>
                        <c:if test="${inven.displayCount <= 1}">
                            <p style="color: red">디스플레이 필요!</p>
                        </c:if>
                        <c:if test="${inven.displayCount > 1}">
                            <p style="color: blue">여유</p>
                        </c:if>
                    </td>
                    <td>
                        <input name="safeInventoryCount" value="10" class="form-control" type="number"
                               style="width: 80px">
                    </td>
                    <td>
                        <c:if test="${inven.inCount le 10}">
                            <p style="color: red; font-weight: bold">주문 필요!</p>
                        </c:if>
                        <c:if test="${inven.inCount > 10}">
                            <p style="color: blue">여유</p>
                        </c:if>
                    </td>

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
                        <c:url value="/inventory/inventoryList" var="pageLink">
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
                        <c:url value="/inventory/inventoryList" var="pageLink">
                            <c:param name="page" value="${pageNum }"></c:param>
                        </c:url>
                        <a class="page-link ${pageNum eq (pageInfo.currentPageNum) ? 'active' : ''}"
                           href="${pageLink }">${pageNum}</a>
                    </li>
                </c:forEach>

                <%-- 다음 페이지 --%>
                <li class="page-item">
                    <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                        <c:url value="/inventory/inventoryList" var="pageLink">
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
