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
    <title>매대 현황</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">

    <style>
        .searchBar{
            text-align: center;
        }

    </style>
</head>
<body>
<my:navBar current="display"></my:navBar>
<my:alert></my:alert>

<script>
    //판매
    function handleButtonClick(){
        var sellAmount = document.getElementById("sellAmount").value;
        var id = document.getElementById("sellNum").value;
        console.log("sellAmount",sellAmount);
        console.log("id",id);
        $.ajax("/sell",{
            method:"post",
            contentType: "application/json",
            data: JSON.stringify({"id" :id, "sellAmount" :sellAmount}),
            success: function (){
                location.reload();
            }
        })
    }

    // 환불
    function handleButtonClick2(){
        var refundAmount = document.getElementById("refundAmount").value;
        var id = document.getElementById("refundNum").value;
        $.ajax("/refund",{
            method:"post",
            contentType: "application/json",
            data: JSON.stringify({"id" :id,"refundAmount" :refundAmount}),
            success: function (){
                location.reload();
            }
        })
    }

    function openModal(event){
        var clickedButtonId = event.target.id;
        var id = clickedButtonId.split("_")[1];
        // 값을 모달 창에 설정
        var modalValue = document.getElementById("sellNum");
        modalValue.value = id;
        console.log("clickedButtonId",clickedButtonId);
        console.log(id);
    }

    function openModal2(event){
        var clickedButtonId = event.target.id;
        var id = clickedButtonId.split("_")[1];
        // 값을 모달 창에 설정
        var modalValue = document.getElementById("refundNum");
        modalValue.value = id;
        console.log("clickedButtonId",clickedButtonId);
        console.log(id);
    }
</script>
<div class="container-lg">

    <h1 style="text-decoration: solid; margin-top: 50px;margin-bottom: 50px;">매대 현황</h1>

    <form action="/list">
        <div class="searchBar">
    <input name="search" class="searchBook" type="search" placeholder="찾으시는 도서를 입력하세요." style="width: 550px; height: 40px; border-radius:5px; ">
        <button type="submit" class="btn btn-outline-secondary">검색
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
        </div>
    </form>

    <button type="button" class="btn btn-outline-secondary" onclick="location.href='/eventBook'" style="margin-bottom: 20px;">이벤트 도서</button>

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
            <th>이벤트</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bookList}" var="book">
            <tr>
                <td>${book.isbn}</td>
                <td>
                        ${book.title}
                    <button type="button" id="sellBtn_${book.id}" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="openModal(event)">판매</button>
                    <button type="button" id="refundBtn_${book.id}" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal2" onclick="openModal2(event)">환불</button>

                </td>
                <td>${book.writer}</td>
                <td>${book.publisher}</td>
                <td>${book.categoryId}</td>
                <td>${book.displayCount}</td>
                <td>${book.totalCount}</td>
                <td>
                    <c:if test="${book.checkEvent == '0'}">
                        <a class="btn btn-outline-secondary" href="/addEvent/${book.id}">이벤트 등록</a>
                    </c:if>
                    <c:if test="${book.checkEvent == '1'}">
                        <a class="btn btn-outline-warning" href="/id/${book.id}">이벤트중</a>
                    </c:if>

                </td>
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
                <input type="hidden" id="sellNum"/>
                수량 입력(숫자만 입력) : ${book.title}
            <input type="text" id="sellAmount"/>
                <c:if test="${book.checkEvent == '1'}">
                    이벤트중인 책입니다.
                </br>
                    ${book.event}
                </c:if>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-outline-primary" onclick="handleButtonClick()">확인</button>
            </div>
        </div>
    </div>
</div>



<!-- Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel2">환불 수량을 입력해 주세요.</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="refundNum"/>
                수량 입력(숫자만 입력) :
                <input type="text" id="refundAmount">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-outline-primary" onclick="handleButtonClick2()">확인</button>
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
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>
<script src="semantic/dist/semantic.min.js"></script>
</body>
