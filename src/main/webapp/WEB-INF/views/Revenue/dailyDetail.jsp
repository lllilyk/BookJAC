<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/03
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>일일 정산 상세 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

</head>
<body>
<div class="container">
    <br>
    <hr>
    <div class="row">
        <div class="col-md-6">
            <h1><fmt:formatDate value="${settlement.inserted}" pattern="yyyy년 MM월 dd일"/> 상세 내역</h1>
        </div>
        <div class="col-md-6 text-end">
            <button id="doughnutChartBtn" type="button" class="btn btn-outline-primary">
                도넛 차트 보기
            </button>
            <button id="excelBtn" class="btn btn-outline-secondary">엑셀 다운</button>
            <a href="/Revenue/daily" class="btn btn-outline-secondary">
                돌아가기
            </a>
        </div>
    </div>

    <%--도넛 차트 --%>
    <div class="container d-none w-50" id="doughnutChartBox">
        <div style="width: 400px;">
            <canvas id="doughnutChartCanvas" ></canvas>
        </div>
    </div>
    <table class="table table-bordered" id="TableToExport">
        <thead>
        <tr>
            <th scope="col">판매 책 제목</th>
            <th scope="col">남은 수량</th>
            <th scope="col">판매 수량</th>
            <th scope="col">입고가</th>
            <th scope="col">출고가</th>
            <th scope="col">판매 순이익</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
        <tfoot>
        <tr>
            <td colspan="2">합계</td>
            <td>총 판매 수량</td>
            <td>원가 총액</td>
            <td>판매가 총액</td>
            <td>순이익 총액</td>
        </tr>
        </tfoot>
    </table>
</div>
${settlement.id}, ${settlement.cash}, ${settlement.card}, ${settlement.vaultCash},${settlement.inserted}


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.min.js" integrity="sha512-mlz/Fs1VtBou2TrUkGzX4VoGvybkD9nkeXWJm3rle0DPHssYYx4j+8kIS15T78ttGfmOjH0lLaBXGcShaVkdkg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"></script>
<script src="https://cdn.sheetjs.com/xlsx-0.20.0/package/dist/xlsx.full.min.js"></script>
<script src="/js/revenue/chart.js"></script>
<script src="/js/revenue/excel.js"></script>

</body>
</html>
