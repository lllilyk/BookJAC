<%--
  Created by IntelliJ IDEA.
  User: ukang
  Date: 2023/07/07
  Time: 2:56 PM
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
    .inboundSellingListContainer {
        padding: 10px;
        border: solid;
        border-color: lightgray;
    }
</style>
<body>

<div class="container-lg mt-3">
    <h1><a href="/bookList" style="color: black; text-decoration-line: none">입고/판매 내역</a></h1>
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
               aria-label="inputSearch" for="inputSearch">
    </div>

    <label for="inputDate" class="form-label">조회일자</label>
    <div class="d-flex" id="inputDate">
        <div style="margin-right: 20px">
            <input type="date" class="form-control" name="startDate" id="inputStartDate" value="">
        </div>
        <div>
            <input type="date" class="form-control" name="EndDate" id="inputEndDate" value="">
        </div>
    </div>
</form>

<%-- 입고/판매 리스트 --%>
<div class="container-lg">
    <button type="button" class="btn btn-success">입고만</button>
    <button type="button" class="btn btn-danger">출고만</button>
    <table class="table">
        <thead>
        <tr>
            <th>#</th>
            <th>도서명</th>
            <th>저자</th>
            <th>출판사</th>
            <th>구분</th>
            <th>입고수</th>
            <th>발주일</th>
            <th>입고예정일</th>
            <th>입고일</th>
            <th>판매수</th>
            <th>판매일</th>
            <th>발주담당자</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bookList }" var="list">
            <tr></tr>
        </c:forEach>
        </tbody>
    </table>
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
