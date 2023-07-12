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
            //판매 책 정보 표 몸통부분 삭제
            $("#soldBookTableBody").empty();

            //판매된 책 내역을 조건에 맞게 다시 조회 후 불러옴
            results.sales.forEach(function (sales, index) {
                $("#soldBookTableBody").append(`
            <tr>
                <td>${index + 1}</td>
                <td>${sales.title}</td>
                <td>${sales.totalCount}</td>
                <td>${sales.soldCount}</td>
                <td>${(sales.inPrice * sales.soldCount).toLocaleString()}</td>
                <td>${(sales.outPrice * sales.soldCount).toLocaleString()}</td>
                <td>${(sales.netIncome).toLocaleString()}</td>
                <td>${sales.pay == 1 ? '현금' : '카드'}</td>
            </tr>
            `);
            });

            //결제 방식을 선택했다면
            if(payWay == 1 || payWay == 2) {
                console.log("click")
                $("#soldBookTableFoot").empty();
                $("#soldBookTableFoot").append(`
                <tr>
                    <th colspan="3">합계</th>
                    <th>${results.sum.soldCount}</th>
                    <th>${results.sum.inPrice.toLocaleString()}</th>
                    <th>${results.sum.outPrice.toLocaleString()}</th>
                    <th>${results.sum.netIncome.toLocaleString()}</th>
                    <th></th>
                </tr>
                `)
            }

            if(bookTitle != "") {
                $("#soldBookTableFoot").empty();
                $("#soldBookTableFoot").append(`
                <tr>
                    <th colspan="3">합계</th>
                    <th>${results.sum.soldCount}</th>
                    <th>${results.sum.inPrice.toLocaleString()}</th>
                    <th>${results.sum.outPrice.toLocaleString()}</th>
                    <th>${results.sum.netIncome.toLocaleString()}</th>
                    <th></th>
                </tr>
                `)
            }
        }
    })
})