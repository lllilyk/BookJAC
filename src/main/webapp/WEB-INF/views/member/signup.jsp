<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" integrity="sha512-t4GWSVZO1eC8BM339Xd7Uphw5s17a86tIZIj8qRxhnKub6WoyhnrxeCIMeAqBPgdZGlCcG2PrZjMc+Wr78+5Xg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<html>
<head>
    <title>Title</title>
</head>
<body>

    <my:alert></my:alert>

    <div class="container-lg">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <h1>회원 가입</h1>
                <form method="post">
                    <div class="mb-3">
                        <label for="inputId" class="form-label">아이디</label>
                        <input id="inputId" type="text" class="form-control" name="id" value="${member.id}"/>
                    </div>
                    <div class="mb-3">
                        <label for="inputPW" class="form-label">패스워드</label>
                        <input id="inputPW" type="password" class="form-control" name="password" />
                    </div>
                    <div class="mb-3">
                        <label for="inputName" class="form-label">이름</label>
                        <input id="inputName" type="text" class="form-control" name="name" value="${member.name}" />
                    </div>
                    <div class="mb-3">
                        <label for="inputMemberNum" class="form-label">사원번호</label>
                        <input id="inputMemberNum" type="text" class="form-control" name="memberNumber" value="${member.memberNumber}" />
                    </div>
                    <div class="mb-3">
                        <label for="inputEmail" class="form-label">이메일</label>
                        <input id="inputEmail" type="email" class="form-control" name="email" value="${member.email}" />
                    </div>
                    <div class="mb-3">
                        <label for="inputPhoneNum" class="form-label">전화번호</label>
                        <input id="inputPhoneNum" type="text" class="form-control" name="phoneNumber" value="${member.phoneNumber}" />
                    </div>
                    <div class="mb-3">
                        <input type="submit" class="btn btn-secondary" value="가입" />
                    </div>
                </form>
            </div>

        </div>
    </div>

    <my:navBar></my:navBar>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js" integrity="sha512-3dZ9wIrMMij8rOH7X3kLfXAzwtcHpuYpEgQg1OA4QAob1e81H8ntUQmQm3pBudqIoySO5j0tHN4ENzA6+n2r4w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</body>
</html>
