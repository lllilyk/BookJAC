<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2023-06-30
  Time: 오후 2:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:alert></my:alert>
<div class="container-lg">

    <h1>매대 현황</h1>

    <form action="/list">
    <input name="search" class="searchBar" type="search" placeholder="검색어를 입력하세요.">
        <button type="submit">검색
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </form>

    <button type="button" onclick="location.href='/addEvent'">이벤트 등록</button>
    <br/>


    <h3>이벤트 도서</h3>
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
                <td>${book.title}</td>

                <td>${book.writer}</td>
                <td>${book.publisher}</td>
                <td>${book.event}</td>
                <td>${book.eventStartDate}</td>
                <td>${book.eventEndDate}</td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
    </div>




    <div>
    <table class="table">
        <thead>
        <tr>
            <th>#</th>
            <th>책 제목</th>
            <th>작가</th>
            <th>출판사</th>
            <th>장르</th>
            <th>매대수량</th>
            <th>총수량</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bookList}" var="book">
            <tr>
                <td>${book.id}</td>
                <td>
                        ${book.title}
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">판매</button>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal2">환불</button>
                </td>
                <td>${book.writer}</td>
                <td>${book.publisher}</td>
                <td>${book.categoryId}</td>
                <td>${book.displayCount}</td>
                <td>${book.totalCount}</td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">판매된 수량을 입력해 주세요.</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                수량 입력(숫자만 입력) :
            <input type="text" name="amount">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary">확인</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">환불 수량을 입력해 주세요.</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                수량 입력(숫자만 입력) :
                <input type="text" name="refund">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary">확인</button>
            </div>
        </div>
    </div>
</div>


<div class="container-lg">
    <div class="row">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">

                <!-- 이전 버튼 -->
                <c:if test="${pageInfo.currentPageNum gt 1 }">
                    <my:pageItem pageNum="${pageInfo.currentPageNum - 1 }">
                        <i class="fa-solid fa-angle-left"></i>
                    </my:pageItem>
                </c:if>

                <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
                    <my:pageItem pageNum="${pageNum }">
                        ${pageNum }
                    </my:pageItem>
                </c:forEach>

                <!-- 다음 버튼 -->
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                    <%-- 페이지 번호 : ${pageInfo.currentPageNum + 1 } --%>
                    <my:pageItem pageNum="${pageInfo.currentPageNum + 1 }">
                        <i class="fa-solid fa-angle-right"></i>
                    </my:pageItem>

                </c:if>

            </ul>
        </nav>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
