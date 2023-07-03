var currentDate = new Date();
var week = ['일', '월', '화', '수', '목', '금', '토'];

$(".modifyBtn").click(function () {
    //수정버튼을 누르면
    const settlementId = $(this).attr("settlement-id");
    console.log(settlementId);
    //기존의 정보를 조회
    $.ajax("/Revenue/getDailyInfo?settlementId=" + settlementId, {
        method: "get",
        success: function (settlement) {
            $("#modifyCash").val(settlement.cash);
            $("#modifyCard").val(settlement.card);
            $("#modifyVaultCash").val(settlement.vaultCash);
        }
    })

    $("#modifyModalBtn").click(function () {
        //수정된 정보 업데이트
        const id = settlementId;
        const cash = $("#modifyCash").val();
        const card = $("#modifyCard").val();
        const vaultCash = $("#modifyVaultCash").val();
        const data = {cash, card, vaultCash};
        console.log(data);
    })
})

$(".deleteBtn").click(function () {
    //삭제버튼을 누르면
    const settlementId = $(this).attr("settlement-id");
    console.log(settlementId);
    $("#settlementIdInput").val(settlementId);

    $("#deleteModalBtn").click(function () {
        //모달 삭제 버튼을 누르면
        $.ajax("/Revenue/deleteDaily?settlementId=" + settlementId, {
            method: "delete",
            success: function () {
                console.log("delete")
                window.location.href = "/Revenue/daily";
            }
        })
    })
})

//정산입력 버튼 누르면 현재 날짜 뜨도록 하기
$("#addBtn").click(function () {
    var month = currentDate.getMonth() + 1; //월
    var day = currentDate.getDate(); //일
    var weekNum = currentDate.getDay();
    var today = month + "월 " + day + "일 " + week[weekNum] + "요일";

    $("#todayBox").text(today);
})
