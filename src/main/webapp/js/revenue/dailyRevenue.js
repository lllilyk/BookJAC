$("#selectBtn").click(function () {
    let settlementId = $("#settlementId").val();
    let selectWay = $("#selectWay").val();
    let payWay = $("#payWay").val();
    let bookTitle = $("#bookTitle").val();

    $.ajax("/Revenue/dailyDetailSearch?settlementId=" + settlementId
        + "&selectWay=" + selectWay
        + "&payWay=" + payWay
        + "&bookTitle=" + bookTitle, {
        method: "get",
        success: function (results) {
            console.log(results);
            //판매된 책 내역을 조건에 맞게 다시 조회 후 불러옴
            $("#soldBookTableBody").empty();
            for (const sales of results.sales) {
                console.log(sales.id)
                //판매 책 정보 표 몸통부분 삭제
                $("#soldBookTableBody").append(`
                <tr>
                    <td>#</td>
                    <td>${sales.title}</td>
                    <td>${sales.totalCount}</td>
                    <td>${sales.soldCount}</td>
                    <td>${sales.inPrice * sales.soldCount}</td>
                    <td>${sales.outPrice * sales.soldCount}</td>
                    <td>${(sales.outPrice * sales.soldCount) - (sales.inPrice * sales.soldCount)}</td>
                    <td>${sales.pay == 1 ? '현금' : '카드'}</td>
                </tr>
                `)

                $("#soldBookTableFoot").empty();
                //판매 책 정보 합계 발부분 삭제

            }
        }
        // success: function (result) {
        //     console.log("click");
        //     $("#TableToExport").empty();
        //     $("#TableToExport").append(`
        // <thead>
        // <tr class="table-primary">
        //     <th colspan="8"><h5><strong>판매 책 정보</strong></h5></th>
        // </tr>
        // <tr>
        //     <th scope="col">#</th>
        //     <th scope="col">판매 책 제목</th>
        //     <th scope="col">남은 수량</th>
        //     <th scope="col">판매 수량</th>
        //     <th scope="col">입고가</th>
        //     <th scope="col">출고가</th>
        //     <th scope="col">판매 순이익</th>
        //     <th scope="col">결제 방법</th>
        // </tr>
        // </thead>
        // <tbody>
        // <c:forEach items="${result.sales}" var="sales" varStatus="num">
        //     <tr>
        //         <td>${num.index + 1}</td>
        //         <td>${sales.title}</td>
        //         <td><fmt:formatNumber groupingUsed="true" value="${sales.totalCount}"/></td>
        //         <td><fmt:formatNumber groupingUsed="true" value="${sales.soldCount}"/></td>
        //         <td><fmt:formatNumber groupingUsed="true" value="${sales.inPrice * sales.soldCount}"/></td>
        //         <td><fmt:formatNumber groupingUsed="true" value="${sales.outPrice * sales.soldCount}"/></td>
        //         <td><fmt:formatNumber groupingUsed="true" value="${(sales.outPrice * sales.soldCount) - (sales.inPrice * sales.soldCount)}"/></td>
        //         <td>${sales.pay == 1 ? '현금' : '카드'}</td>
        //     </tr>
        // </c:forEach>
        // </tbody>
        // <tfoot>
        // <tr>
        //     <th colspan="2">합계</th>
        //     <th><fmt:formatNumber groupingUsed="true" value="${sum.sumSoldCount}"/></th>
        //     <th><fmt:formatNumber groupingUsed="true" value="${sum.sumInPrice}"/></th>
        //     <th><fmt:formatNumber groupingUsed="true" value="${sum.sumOutPrice}"/></th>
        //     <th><fmt:formatNumber groupingUsed="true" value="${sum.sumOutPrice - sum.sumInPrice}"/></th>
        //     <th><fmt:formatNumber groupingUsed="true" value="${sum.sumNetIncome}"/></th>
        //     <th></th>
        // </tr>
        // </tfoot>
        //     `);
        // }
    })
    console.log(settlementId)
    console.log(selectWay)
    console.log(payWay)
    console.log(bookTitle)


})