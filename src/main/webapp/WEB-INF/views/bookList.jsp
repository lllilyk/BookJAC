<%--
  Created by IntelliJ IDEA.
  User: ukang
  Date: 2023/07/03
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    <title>Title</title>
</head>

<style>
    .row.g-2.mb-3 {
        margin: 0px 10px 0px 10px;
    }

    .mb-3.d-flex {
        margin: 0px 10px 0px 10px;
    }

    .bookListContainer {
        border: solid;
        border-color: lightgray;
    }
</style>
<body>

<div class="container-lg mt-3">
    <h1>전체 도서 목록</h1>
</div>

<%-- search --%>
<form class="bookListContainer container-lg mt-3 mb-4">
    <div class="row g-2 mb-3">
        <div class="col-md">
            <label for="inputTitle" class="form-label">도서명</label>
            <input type="text" class="form-control" id="inputTitle">
        </div>
        <div class="col-md">
            <label for="inputPublisher" class="form-label">출판사</label>
            <input type="text" class="form-control" id="inputPublisher">
        </div>
    </div>
    <div class="mb-3 d-flex">
        <div class="p-1">
            <label for="inputInPrice" class="form-label">입고가</label>
            <select class="form-select" aria-label="Default select example" id="inputInPrice" style="width: 310px">
                <option selected>범위를 선택 해 주세요.</option>
                <option value="1">0 - 10,000</option>
                <option value="2">10,000 - 50,000</option>
                <option value="3">50,000 - 100,000</option>
            </select>
        </div>
        <div class="p-1">
            <label for="inputOutPrice" class="form-label">출고가</label>
            <select class="form-select" aria-label="Default select example" id="inputOutPrice" style="width: 310px">
                <option selected>범위를 선택 해 주세요.</option>
                <option value="1">0 - 10,000</option>
                <option value="2">10,000 - 50,000</option>
                <option value="3">50,000 - 100,000</option>
            </select>
        </div>
        <div class="ms-auto mt-auto p-2">
            <button type="" class="btn btn-secondary">리셋</button>
            <button type="submit" class="btn btn-primary">찾기</button>
        </div>
    </div>
</form>

<%-- bookList 테이블 --%>

<div class="container-lg">
    <table class="table">
        <thead>
        <tr>
            <th>일련번호</th>
            <th>도서명</th>
            <th>저자</th>
            <th>출판사</th>
            <th>카테고리</th>
            <th>입고가</th>
            <th>판매가</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bookList }" var="list">
            <tr>
                <td>${list.id }</td>
                <td>${list.title}</td>
                <td>${list.writer }</td>
                <td>${list.publisher }</td>
                <td>${list.categoryId }</td>
                <td>${list.inPrice }</td>
                <td>${list.outPrice }</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%-- 페이지네이션 --%>
<div class="container-lg">
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>

            <c:forEach begin="${pageInfo.page + 1 }" end="${pageInfo.lastPageNum }" var="pageNum">
                <li class="page-item">
                    <c:url value="/bookList" var="pageLink">
                        <c:param name="page" value="${pageNum }"></c:param>
                    </c:url>
                    <a class="page-link ${pageNum eq (pageInfo.currentPageNum) ? 'active' : ''}"
                       href="${pageLink }">${pageNum}</a>
                </li>
            </c:forEach>

            <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
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
</body>
</html>
