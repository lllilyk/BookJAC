<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2023-07-27
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>이벤트 내용</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:navBar current="getEvent"></my:navBar>
<my:alert></my:alert>

<div class="container-lg">
    <h1>${book.title}의 이벤트 내용</h1>
    <div>
        책 제목: ${book.title}
    </div>
    <div>
        작가: ${book.writer}
    </div>
    <div>
        출판사: ${book.publisher}
    </div>
    <div>
        이벤트 내용: ${book.event}
    </div>
    <div>
        이벤트 시작 날짜: ${book.eventStartDate}
    </div>
    <div>
        이벤트 종료 날짜: ${book.eventEndDate}
    </div>
</div>

<div>
    <a class="btn btn-outline-secondary" href="/modifyEvent/${book.id}">수정하기</a>
    <button class="btn btn-outline-danger" form="removeForm" type="submit">삭제하기</button>
</div>
</div>

<div class="d-done">
    <form action="/removeEvent" method="post" id="removeForm">
        <input type="text" name="id" value="${book.id}"/>
    </form>
</div>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
