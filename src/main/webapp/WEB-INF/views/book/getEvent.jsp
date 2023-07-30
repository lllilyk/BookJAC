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
    <link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">

</head>
<body>
<my:navBar current="getEvent"></my:navBar>


<div class="container-lg">
    <div style="margin: 50px 200px 300px 200px; border: 8px double gray;">
        <form class="ui form" style="margin: 30px 100px 60px 100px">
            </br>
    <h1 class="ui dividing header" style="text-align:center;">
        '${book.title}'의 이벤트 내용</h1>
     </br>

    <input type="hidden" name="id" value="${book.id}" />

        <div class="field">
            <h4 class="ui header">책 제목</h4>
            <div class="field">

                <input type="text" name="title" value="${book.title }" disabled />

            </div>
        </div>

            <div class="field">
                <h4 class="ui header">작가</h4>
                <input type="text" name="writer" value="${book.writer}" disabled />
            </div>

            <div class="field">
                <h4 class="ui header">출판사</h4>
                <input type="text" name="publisher" value="${book.publisher}" disabled />
            </div>

            <h4 class="ui header">이벤트 내용</h4>
            <div class="field">

                <textarea name="event" value="${book.event}" rows="10" disabled>${book.event}</textarea>
            </div>
</br>
            <div style="display: flex; justify-content: flex-start;">
                <div class="field">
                    <h4 class="ui header">이벤트 시작일</h4>
                    <input type="date" name="eventStartDate" id="eventStart" value="${book.eventStartDate}" disabled>
                </div>

                <div class="field">
                    <h4 class="ui header">이벤트 종료일</h4>
                    <input type="date" name="eventEndDate" id="eventEnd" value="${book.eventEndDate}" disabled>
                </div>
            </div>
</br>
<div>
    <a class="btn btn-outline-secondary" href="/modifyEvent/${book.id}">수정하기</a>
    <button class="btn btn-outline-danger" form="removeForm" type="submit">삭제하기</button>
</div>

</form>
</div>
</div>



<div class="d-done">
    <form action="/removeEvent" method="post" id="removeForm">
        <input type="hidden" name="id" value="${book.id}"/>
        <input type="hidden" name="title" value="${book.title}"/>
        <input type="hidden" name="checkEvent" value="${book.checkEvent}"/>
    </form>
</div>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>
<script src="semantic/dist/semantic.min.js"></script>
<c:if test="${not empty param.success}">
    <script>
        alert("이벤트가 수정되었습니다.");
    </script>
</c:if>
</body>
</html>
