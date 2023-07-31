$("button[id^='checkInbound']").click(function () {
    const buttonId = this.id;
    const cartId = buttonId.split("_")[1];
    const index = buttonId.split("_")[2];

    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    const clickedDate = year + '-' + month + '-' + day;
    const data = {
        cartId: cartId,
        clickedDate: clickedDate
    };

    $.ajax("/inventory/inbound/" + cartId + "/" + clickedDate, {
        method: "post",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function (data) {
            console.log(data);
            if (data.inbounded) {
                $("#" + buttonId).removeClass("btn-outline-danger").addClass("btn-outline-primary btn-sm").text("입고됨");
                $("#inboundDate_" + cartId + "_" + index).text(clickedDate);
                $("#totalCount_" + cartId + "_" + index).css("color", "blue").css("font-weight", "bold").text(data.totalC);
            } else {
                $("#" + buttonId).removeClass("btn-outline-primary").addClass("btn-outline-danger btn-sm").text("입고전");
                $("#inboundDate_" + cartId + "_" + index).empty();
                $("#totalCount_" + cartId + "_" + index).css("color", "blue").css("font-weight", "bold").text(data.totalmi);

            }
        }
    });
});

$("button[id^='checkInbounded']").click(function () {
    const buttonId = this.id;
    const cartId = buttonId.split("_")[1];
    const index = buttonId.split("_")[2];

    // ... AJAX 요청 등 필요한 처리 ...

    // 입고됨 버튼을 클릭했을 때 totalCount를 data.totalmi로 업데이트
    // 이후의 처리를 여기에 추가
    $("#totalCount_" + cartId + "_" + index).css("color", "blue").css("font-weight", "bold").text(data.totalmi);
});

function handleInbound(cartId) {
    const book = {cartId: cartId};
    $.ajax("/inventory/inbound", cartId + "/" + clickedDate, {
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(book),
        success: function (data) {
            alert("도서목록으로 추가 되었습니다."); // 실패 메시지 표시
        },
        error: function () {
            alert("서버와 통신 중 오류가 발생했습니다.");
        }
    });
}

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

