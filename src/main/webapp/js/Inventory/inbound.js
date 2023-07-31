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
                $("#" + buttonId).removeClass("btn-outline-danger").addClass("btn-outline-primary btn-sm").text("입고됌");
                $("#inboundDate_" + cartId + "_" + index).text(clickedDate);
                $("#totalCount_" + cartId + "_" + index).css("color", "blue").css("font-weight", "bold").text(data.total);
            } else {
                $("#" + buttonId).removeClass("btn-outline-primary").addClass("btn-outline-danger btn-sm").text("입고전");
                $("#inboundDate_" + cartId + "_" + index).empty();
                const stock = parseInt(bookTotal) - parseInt(totalmi);
                //const displayStock = isNaN(stock) ? 0 : stock;
                $("#totalCount_" + cartId + "_" + index).css("color", "blue").css("font-weight", "bold").text(stock);

            }
        }
    });
});


// function handleInbound(bookId) {
//     const book = {bookId: bookId};
//     $.ajax("/inventory/inbound", {
//         type: "POST",
//         contentType: "application/json",
//         data: JSON.stringify(book),
//         success: function (data) {
//             alert("도서목록으로 추가 되었습니다."); // 실패 메시지 표시
//         },
//         error: function () {
//             alert("서버와 통신 중 오류가 발생했습니다.");
//         }
//     });
// }

// $("button[id^='checkInbounded']").click(function () {
//     const buttonId = this.id;
//     const cartId = buttonId.split("_")[1];
//
//     $.ajax("/inventory/inbound/" + cartId, {
//         method: "delete",
//         success: function (data) {
//             console.log(data);
//             if (data.success) {
//                 // 성공적으로 삭제되면 페이지를 새로고침하여 도서 목록을 갱신합니다.
//                 location.reload();
//             } else {
//                 alert("삭제 실패: " + data.message); // 실패 시 알림을 표시합니다.
//             }
//         },
//         error: function () {
//             alert("서버와 통신 중 오류가 발생했습니다.");
//         }
//     });
// });

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

