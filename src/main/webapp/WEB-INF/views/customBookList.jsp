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
    .bookListContainer {
        padding: 10px;
        border: solid;
        border-color: lightgray;
    }
</style>
<body>

<div class="container-lg mt-3">
    <h1><a href="/bookList" style="color: black; text-decoration-line: none">찾으시는 책을 검색 해 보세요.</a></h1>
</div>

<%-- search --%>
<form class="bookListContainer container-lg mt-3 mb-4">
    <div class="row g-3">
        <div class="col-md">
            <label for="inputTitle" class="form-label">도서명</label>
            <input type="text" class="form-control" name="title" id="inputTitle" value="${param.title}">
        </div>
        <div class="col-md">
            <label for="inputWriter" class="form-label">저자</label>
            <input type="text" class="form-control" name="writer" id="inputWriter" value="${param.writer}">
        </div>
        <div class="col-md">
            <label for="inputPublisher" class="form-label">출판사</label>
            <input type="text" class="form-control" name="publisher" id="inputPublisher" value="${param.publisher}">
        </div>
    </div>
    <div class="mt-3 d-flex">
        <div style="margin-right: 20px">
            <label for="inputCategoryId" class="form-label">장르</label>
            <select class="form-select" aria-label="Default select example" name="genre" id="inputCategoryId"
                    style="width: 420px">
                <option selected value="">장르를 선택 해 주세요.</option>
                <option value="1" ${param.genre eq 1 ? 'selected' : ''}>문학</option>
                <option value="2" ${param.genre eq 2 ? 'selected' : ''}>육아</option>
                <option value="3" ${param.genre eq 3 ? 'selected' : ''}>문제집</option>
                <option value="4" ${param.genre eq 4 ? 'selected' : ''}>요리</option>
                <option value="5" ${param.genre eq 5 ? 'selected' : ''}>예술</option>
            </select>
        </div>
        <div>
            <label for="inputOutPrice" class="form-label">금액</label>
            <select class="form-select" aria-label="Default select example" name="sellingPrice" id="inputOutPrice"
                    style="width: 420px">
                <option selected value="">범위를 선택 해 주세요.</option>
                <option value="1" ${param.sellingPrice eq 1 ? 'selected' : ''}>0 - 10,000</option>
                <option value="2" ${param.sellingPrice eq 2 ? 'selected' : ''}>10,000 - 50,000</option>
                <option value="3" ${param.sellingPrice eq 3 ? 'selected' : ''}>50,000 - 100,000</option>
                <option value="4" ${param.sellingPrice eq 4 ? 'selected' : ''}>100,000 이상</option>
            </select>
        </div>
        <div class="ms-auto mt-auto">
            <input type="button" class="btn btn-secondary" onclick='location.href="/customBookList"' value="리셋"></input>
            <button type="submit" class="btn btn-primary">찾기</button>
        </div>
    </div>
</form>

<%-- bookList 테이블 --%>

<div class="container-lg">
    <table class="table">
        <thead>
        <tr>
            <th>#</th>
            <th>위치</th>
            <th>장르</th>
            <th>도서명</th>
            <th>저자</th>
            <th>출판사</th>
            <th>금액</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bookList }" var="list">
            <tr>
                <td>${list.id }</td>
                <td>${list.categoryId }</td>
                <td>
                    <c:choose>
                        <c:when test="${list.categoryId eq 1}">문학</c:when>
                        <c:when test="${list.categoryId eq 2}">육아</c:when>
                        <c:when test="${list.categoryId eq 3}">문제집</c:when>
                        <c:when test="${list.categoryId eq 4}">요리</c:when>
                        <c:when test="${list.categoryId eq 5}">예술</c:when>
                        <c:otherwise>기타</c:otherwise>
                    </c:choose>
                </td>
                <td>${list.title}</td>
                <td>${list.writer }</td>
                <td>${list.publisher }</td>
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

            <%-- 이전 페이지 --%>
            <li class="page-item">
                <c:if test="${pageInfo.currentPageNum gt 1 }">
                    <c:url value="/customBookList" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum - 1}"></c:param>
                        <c:param name="title" value="${param.title }"></c:param>
                        <c:param name="publisher" value="${param.publisher }"></c:param>
                        <c:param name="cost" value="${param.cost }"></c:param>
                        <c:param name="sellingPrice" value="${param.sellingPrice }"></c:param>
                    </c:url>
                    <a class="page-link" href="${pageLink}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </c:if>
            </li>

            <%-- 페이지 목록--%>
            <c:forEach begin="${pageInfo.page + 1 }" end="${pageInfo.searchLastPageNum}" var="pageNum">
                <li class="page-item">
                    <c:url value="/customBookList" var="pageLink">
                        <c:param name="page" value="${pageNum }"></c:param>
                        <c:param name="title" value="${param.title }"></c:param>
                        <c:param name="publisher" value="${param.publisher }"></c:param>
                        <c:param name="cost" value="${param.cost }"></c:param>
                        <c:param name="sellingPrice" value="${param.sellingPrice }"></c:param>
                    </c:url>
                    <a class="page-link ${pageNum eq (pageInfo.currentPageNum) ? 'active' : ''}"
                       href="${pageLink }">${pageNum}</a>
                </li>
            </c:forEach>

            <%-- 다음 페이지 --%>
            <li class="page-item">
                <c:if test="${pageInfo.currentPageNum lt pageInfo.searchLastPageNum }">
                    <c:url value="/customBookList" var="pageLink">
                        <c:param name="page" value="${pageInfo.currentPageNum + 1}"></c:param>
                        <c:param name="title" value="${param.title }"></c:param>
                        <c:param name="publisher" value="${param.publisher }"></c:param>
                        <c:param name="cost" value="${param.cost }"></c:param>
                        <c:param name="sellingPrice" value="${param.sellingPrice }"></c:param>
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

</body>
</html>
