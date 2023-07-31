<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2023-07-24
  Time: 오전 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 검색 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

    <style>
        .row {
            margin: 10px 0px 20px 0px;
        }
        img {
            max-width: 100px;
            max-height: 100px;
        }
    </style>
</head>
<body>
<my:alert></my:alert>
<div class="ui center aligned container" id="container">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="row">
                <div class="col-md-6">
                    <h1>도서 검색 결과</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="/cart/<sec:authentication property='name'/>" class="btn btn-outline-success">발주품목</a>
                    <a href="/order/process" class="btn btn-outline-dark">돌아가기</a>
                </div>
            </div>
            <%--네이버 오픈 API를 활용한 도서 검색--%>
            <div class="container">
                <form id="bookSearchForm" method="get">
                    <div class="input-group mb-3">
                        <input type="text" id="searchBook" class="form-control" placeholder="원하시는 도서명을 입력하세요" aria-describedby="bookSearchBtn" style="height: 50px; text-align: center;">
                        <button class="btn btn-outline-dark" type="submit" id="bookSearchBtn">검색</button>
                    </div>
                </form>
            </div>
            <table class="table table-bordered searchResults" style="text-align: center">
                <thead>
                <tr>
                    <th style="width:50px;">ISBN</th>
                    <th style="width:100px;">이미지</th>
                    <th style="width:200px;">제목</th>
                    <th style="width:100px;">글쓴이</th>
                    <th style="width:100px;">출판사</th>
                    <th style="width:100px;">출간일</th>
                    <th style="width:100px;">단가</th>
                    <th style="width:165px;">발주수량</th>
                    <th style="width:70px;">발주</th>
                </tr>
                </thead>
                <c:forEach items="${books}" var="book" varStatus="bookStatus">
                    <tr class="${book.isbn == null || book.isbn=='' ? 'd-none' : ''}">
                        <td class="bookId" id="bookIsbnText_${bookStatus.index}">${book.isbn}</td>
                        <td class="border-box"><img src="${book.image}" alt="${book.title}" /></td>
                        <td class="title">${book.title}</td>
                        <td class="writer">${book.author}</td>
                        <td class="publisher">${book.publisher}</td>
                        <td>${book.pubdate}</td>
                        <td class="inPrice">${book.discount }</td>
                        <td>
                            <div class="btn">
                                <div class="btn_quantity">
                                    <div class="input-group">
                                        <button id="minus_btn_${bookStatus.index}" type="button"
                                                class="btn btn-light minus_btn">-
                                        </button>
                                        <input id="quantity_input_${bookStatus.index}" type="text"
                                               class="form-control quantity_input" value="1"
                                               style="width:55px; text-align: center">
                                        <button id="plus_btn_${bookStatus.index}" type="button"
                                                class="btn btn-light plus_btn">+
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <button id="btn_cart_${bookStatus.index}" type="button"
                                    class="btn btn-outline-danger btn_cart"> 등록
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/order/search.js"></script>
</body>
</html>
