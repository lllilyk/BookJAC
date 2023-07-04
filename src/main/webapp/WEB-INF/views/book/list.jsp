<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2023-06-30
  Time: 오후 2:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container-lg">
    <h1>도서 목록</h1>
        <tr>
            <th>#</th>
            <th>책 제목</th>
            <th>작가</th>
            <th>출판사</th>
            <th>장르</th>
            <th>입고가</th>
            <th>출고가</th>
            <th>입고수량</th>
            <th>매대수량</th>
            <th>총수량</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bookList}" var="book">
            <tr>
                <td>${book.id}</td>
                <td>${book.title}</td>
                <td>${book.writer}</td>
                <td>${book.publisher}</td>
                <td>${book.categoryId}</td>
                <td>${book.inPrice}</td>
                <td>${book.outPrice}</td>
                <td>${book.inCount}</td>
                <td>${book.outPrice}</td>
                <td>${book.displayCount}</td>
                <td>${book.totalCount}</td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
</div>


</body>
