$("button[id^='checkInbound']").click(function () {
    const buttonId = this.id;
    const bookId = buttonId.split("_")[1]; // 버튼 ID에서 bookId를 추출합니다.

    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해준 후 2자리로 맞춰줍니다.
    const day = String(today.getDate()).padStart(2, '0'); // 일도 2자리로 맞춰줍니다.

    const clickedDate = year + '-' + month + '-' + day;
    const data = {
        bookId: bookId,
        clickedDate: clickedDate
    };

    $.ajax("/inventory/inbound/" + bookId + "/" + clickedDate, {
        method: "post",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function (data) {
            console.log(data);
            if (data.inbounded) {
                $("#" + buttonId).removeClass("btn-outline-danger").addClass("btn-outline-primary btn-sm").text("입고됌");
                $("#inboundDate_" + bookId).text(clickedDate);
                $("#totalCount_" + bookId).css("color", "blue").css("font-weight", "bold");
            } else {
                $("#" + buttonId).removeClass("btn-outline-primary").addClass("btn-outline-danger btn-sm").text("입고전");
                $("#inboundDate_" + bookId).empty();
            }
        }
    });
});


$(document).ready(function () {
    // "입고전만" 버튼 클릭 시 입고된 도서 숨기고 입고전 도서 보이기
    $("#showInboundBtn").click(function () {
        $(".bookRow.inbounded").hide();
        $(".bookRow.inbound").show();
    });

    // "입고됌만" 버튼 클릭 시 입고전 도서 숨기고 입고된 도서 보이기
    $("#showInboundedBtn").click(function () {
        $(".bookRow.inbound").hide();
        $(".bookRow.inbounded").show();
    });

    // "전체" 버튼 클릭 시 모든 도서 보이기
    $("#showAllBtn").click(function () {
        $(".bookRow").show();
    });
});
