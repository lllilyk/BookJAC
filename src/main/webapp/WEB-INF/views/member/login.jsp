<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" integrity="sha512-t4GWSVZO1eC8BM339Xd7Uphw5s17a86tIZIj8qRxhnKub6WoyhnrxeCIMeAqBPgdZGlCcG2PrZjMc+Wr78+5Xg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<html>
<head>

</head>
<body style="background: #e2e2e2;">

  <div id="container" class="container-lg">
    <div class="row justify-content-center">
      <div style="margin-top: 30vh;" class="col-12 col-md-8 col-lg-6">
        <h1 style="font-weight: bold;" align="center">로그인</h1>
        <form method="post">
          <div class="mb-3">
            <label class="form-label" for="inputUsername">
              ID
            </label>
            <input id="inputUsername" class="form-control" type="text" name="username" />
          </div>
          <div class="mb-3">
            <label class="form-label" for="inputPassword">
              PASSWORD
            </label>
            <input id="inputPassword" class="form-control" type="password" name="password" />
          </div>
          <div align="center" style="margin-top: 5vh;">
            <input class="btn btn-secondary" type="submit" value="로그인" />
          </div>
        </form>
      </div>
    </div>
  </div>

  <my:navBar></my:navBar>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js" integrity="sha512-3dZ9wIrMMij8rOH7X3kLfXAzwtcHpuYpEgQg1OA4QAob1e81H8ntUQmQm3pBudqIoySO5j0tHN4ENzA6+n2r4w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</body>
</html>
