<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/06/30
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>일일 정산</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

</head>
<body>
<h1>일일 정산 내역</h1>
<div class="container">
    <table class="table table-bordered">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">매출 일자</th>
            <th scope="col">현금 매출액</th>
            <th scope="col">카드 매출액</th>
            <th scope="col">시재금</th>
            <th scope="col">수입내역</th>
            <th scope="col">순수익</th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <tr>
            <th scope="row">3</th>
            <th scope="row">2023-02-03</th>
            <th scope="row">1000</th>
            <th scope="row">1000</th>
            <th scope="row">1000</th>
            <th scope="row">1000</th>
            <th scope="row">1000</th>
<%--            <td colspan="2">Larry the Bird</td>--%>
<%--            <td>@twitter</td>--%>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="2">합계</td>
            <td>현금 총액</td>
            <td>카드 총액</td>
            <td>시재금 빈칸</td>
            <td>수입내역 총액</td>
            <td>순수익 총액</td>
        </tr>
        </tfoot>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
