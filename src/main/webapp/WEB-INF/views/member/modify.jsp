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

    <my:alert></my:alert>

    <div class="container-lg">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <h1>회원 정보 수정</h1>
                <form id="modifyForm" action="/member/modify" method="post">
                    <div class="mb-3">
                        <label class="form-label" for="inputId">
                        ID
                        </label>
                        <input id="inputId" class="form-control" type="text" name="id" value="${member.id}" readonly />
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputPassword">
                        PASSWORD
                        </label>
                        <input id="inputPassword" class="form-control" type="text" name="password" value="" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputName">
                        이름
                        </label>
                        <input id="inputName" class="form-control" type="text" name="name" value="${member.name}" readonly/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputMemberNumber">
                        사원번호
                        </label>
                        <input id="inputMemberNumber" class="form-control" type="text" name="memberNumber" value="${member.memberNumber}" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputEmail">
                        email
                        </label>
                        <input id="inputEmail" class="form-control" type="email" name="email" value="${member.email}" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputPhoneNumber">
                        전화번호
                        </label>
                        <input id="inputPhoneNumber" class="form-control" type="text" name="phoneNumber" value="${member.phoneNumber}" />
                    </div>

                    <button type="button" data-bs-toggle="modal" data-bs-target="#confirmModal" class="btn btn-secondary">수정</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 수정 확인 Modal -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="inputOldPassword" class="form-label"></label>
                    <input form="modifyForm" id="inputOldPassword" class="form-control" name="oldPassword" type="text" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" form="modifyForm" class="btn btn-primary">확인</button>
                </div>
            </div>
        </div>
    </div>

    <my:navBar></my:navBar>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js" integrity="sha512-3dZ9wIrMMij8rOH7X3kLfXAzwtcHpuYpEgQg1OA4QAob1e81H8ntUQmQm3pBudqIoySO5j0tHN4ENzA6+n2r4w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</body>
</html>
