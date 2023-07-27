<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2023-07-26
  Time: 오후 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>이벤트 도서 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:navBar current="event"></my:navBar>
<my:alert></my:alert>


<div class="container-lg">
    <h1>이벤트 도서 목록</h1>


    <form action="/list">
        <input name="search" class="searchBar" type="search" placeholder="검색어를 입력하세요.">
        <button type="submit" class="btn btn-outline-secondary">검색
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </form>

    <button type="button" class="btn btn-outline-secondary" onclick="location.href='/addEvent'">이벤트 등록</button>


    <div>
        <table class="table">
            <thead>
            <tr>
                <th>책 제목</th>
                <th>작가</th>
                <th>출판사</th>
                <th>이벤트 내용</th>
                <th>이벤트 시작일</th>
                <th>이벤트 종료일</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${eventList}" var="book">
                <tr>
                    <td>${book.title}
                        <button type="button" class="btn btn-outline-danger">삭제</button>
                    </td>

                    <td>${book.writer}</td>
                    <td>${book.publisher}</td>
                    <td>
                    <a href="/id/${book.id}">${book.event}</a>
                    </td>
                    <td>${book.eventStartDate}</td>
                    <td>${book.eventEndDate}</td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
