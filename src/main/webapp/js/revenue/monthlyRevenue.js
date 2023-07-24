$("#selectWayBtn").click(function () {
    //조회버튼을 누르면
    //연도검색 값과 조회순서 값을 가져옴
    let year = $("#yearInput").val();
    let selectWay = $("#selectWayInput").val();

    $.ajax("/Revenue/monthlySearch?year=" + year + "&" + "selectWay=" + selectWay, {
        method: "get",
        success: function (settlements) {
            console.log(settlements)
            $("#listBody").empty();
            for (let i = 0; i < settlements.length; i++) {
                const settlement = settlements[i]
                const formattedDate = formatDate(settlement.inserted);
                $("#listBody").append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${formattedDate}</td>
                    <td>${settlement.sumIncome}</td>
                    <td>${settlement.sumOutcome != null ? settlement.sumOutcome : 0}</td>
                    <td>${settlement.sumNetIncome != null ? settlement.sumNetIncome : 0}</td>
                </tr>
                `);
            }
        }
    })
})

// "yyyy년 mm월" 형식으로 날짜를 변환하는 함수
function formatDate(dateStr) {
    const date = new Date(dateStr);
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    return `${year}년 ${String(month).padStart(2, '0')}월`;
}