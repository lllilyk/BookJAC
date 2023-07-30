<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" integrity="sha512-t4GWSVZO1eC8BM339Xd7Uphw5s17a86tIZIj8qRxhnKub6WoyhnrxeCIMeAqBPgdZGlCcG2PrZjMc+Wr78+5Xg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<html>
<head>
    <title>Title</title>
</head>
<body style="background: #e2e2e2;">

    <my:navBar></my:navBar>

    <my:alert></my:alert>

    <div style="margin-top: 10vh;" class="container-lg">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <h1 align="center" style=" font-weight: bold; margin-bottom: 5vh;">회원 가입</h1>

                <form method="post">

                    <div class="mb-3">
                        <label for="inputId" class="form-label">아이디</label>
                        <div class="input-group">
                            <input id="inputId" type="text" class="form-control" name="id" value="${member.id}"/>
                            <button class="btn btn-outline-secondary" type="button" id="checkIdBtn" style="font-weight: bold;">중복확인</button> <%--submit 역할 못하게 type 값 button으로--%>
                        </div>

                        <div class="d-none form-text text-primary" id="availableIdMessage">
                            <i class="fa-solid fa-check"></i>
                            사용 가능한 ID입니다.
                        </div>

                        <div class="d-none form-text text-danger" id="notAvailableMessage">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            사용 불가능한 ID입니다.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="inputPW" class="form-label">패스워드</label>
                        <input id="inputPW" type="password" class="form-control" name="password" />
                    </div>

                    <div class="mb-3">
                        <label for="inputPWCheck" class="form-label">패스워드 확인</label>
                        <input id="inputPWCheck" type="password" class="form-control" />

                        <div id="passwordSuccessText" class="d-none form-text text-primary">
                            <i class="fa-solid fa-check"></i>
                            패스워드가 일치합니다.
                        </div>

                        <div id="passwordFailText" class="d-none form-text text-danger">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            패스워드가 일치하지 않습니다.
                        </div>
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
                        <div class="input-group">
                            <input id="inputEmail" type="email" class="form-control" name="email" value="${member.email}" />
                            <button class="btn btn-outline-secondary" type="button" id="checkEmailBtn" style="font-weight: bold;">중복확인</button>
                        </div>

                        <div class="d-none form-text text-primary" id="availableEmailMessage">
                            <i class="fa-solid fa-check"></i>
                            사용 가능한 이메일입니다.
                        </div>

                        <div class="d-none form-text text-danger" id="notAvailableEmailMessage">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            사용 불가능한 이메일입니다.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="inputPhoneNum" class="form-label">전화번호</label>
                        <div class="input-group">
                            <input id="inputPhoneNum" type="text" class="form-control" name="phoneNumber" value="${member.phoneNumber}" />
                            <button class="btn btn-outline-secondary" type="button" id="checkPhoneNumberBtn" style="font-weight: bold;">중복확인</button>
                        </div>

                        <div class="d-none form-text text-primary" id="availablePhoneNumberMessage">
                            <i class="fa-solid fa-check"></i>
                            사용 가능한 전화번호입니다.
                        </div>

                        <div class="d-none form-text text-danger" id="notAvailablePhoneNumberMessage">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            사용 불가능한 전화번호입니다.
                        </div>
                    </div>

                    <div align="center" style="margin-top: 5vh;" class="mb-3">
                        <input id="signupSubmit" type="submit" class="btn btn-secondary" disabled value="가입" />
                    </div>
                </form>
            </div>

        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js" integrity="sha512-3dZ9wIrMMij8rOH7X3kLfXAzwtcHpuYpEgQg1OA4QAob1e81H8ntUQmQm3pBudqIoySO5j0tHN4ENzA6+n2r4w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="/js/member/signup.js"></script>

</body>
</html>
