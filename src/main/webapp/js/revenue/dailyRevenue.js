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
                <td>${sales.inPrice * sales.soldCount}</td>
                <td>${sales.outPrice * sales.soldCount}</td>
                <td>${(sales.outPrice * sales.soldCount) - (sales.inPrice * sales.soldCount)}</td>
                <td>${sales.pay == 1 ? '현금' : '카드'}</td>
            </tr>
            `);
            });
        }
    })
})