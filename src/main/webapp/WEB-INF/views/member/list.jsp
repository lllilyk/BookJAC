<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" integrity="sha512-t4GWSVZO1eC8BM339Xd7Uphw5s17a86tIZIj8qRxhnKub6WoyhnrxeCIMeAqBPgdZGlCcG2PrZjMc+Wr78+5Xg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<html>
<head>
    <title>Title</title>
</head>
<body style="background: #e2e2e2;">

<div style="margin-top: 10vh;" class="container-lg">
    <div class="row justify-content-center">
      <div class="col-12">
        <h1 align="center" style=" font-weight: bold; margin-bottom: 5vh;">회원 목록</h1>
        <table class="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>PASSWORD</th>
              <th>이름</th>
              <th>사원번호</th>
              <th>email</th>
              <th>전화번호</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${memberList}" var="member">
              <tr>
                <td>
                  <c:url value="/member/info" var="memberInfoLink">
                    <c:param name="id" value="${member.id}"></c:param>
                  </c:url>
                  <a href="${memberInfoLink}">
                    ${member.id}
                  </a>
                </td>
                <td>${member.password}</td>
                <td>${member.name}</td>
                <td>${member.memberNumber}</td>
                <td>${member.email}</td>
                <td>${member.phoneNumber}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>

<my:navBar></my:navBar>


<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js" integrity="sha512-3dZ9wIrMMij8rOH7X3kLfXAzwtcHpuYpEgQg1OA4QAob1e81H8ntUQmQm3pBudqIoySO5j0tHN4ENzA6+n2r4w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</body>
</html>
