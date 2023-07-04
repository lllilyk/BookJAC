var currentDate = new Date();
var week = ['일', '월', '화', '수', '목', '금', '토'];

//정산입력 버튼 누르면 현재 날짜 뜨도록 하기
$("#addBtn").click(function () {
    var year = currentDate.getFullYear();
    var month = currentDate.getMonth() + 1; //월
    var day = currentDate.getDate(); //일
    var weekNum = currentDate.getDay();
    var today = month + "월 " + day + "일 " + week[weekNum] + "요일";

    $("#todayBox").text(today);
})

// 일일 정산 수정 과정
$(".modifyBtn").click(function () {
    //수정버튼을 누르면
    const settlementId = $(this).attr("settlement-id");
    console.log(settlementId);
    const dateInfo = $("#dateLink"+settlementId).text();
    console.log(dateInfo);
    $("#modifyDayBox").text(dateInfo);

    //기존의 정보를 조회
    $.ajax("/Revenue/getDailyInfo?settlementId=" + settlementId, {
        method: "get",
        success: function (settlement) {
            $("#modifyCash").val(settlement.cash);
            $("#modifyCard").val(settlement.card);
            $("#modifyVaultCash").val(settlement.vaultCash);
            $("#modifyId").val(settlementId);
        }
    })

})

$("#modifyModalBtn").click(function () {
    //입력된 정보로 수정
    const id = $("#modifyId").val();;
    const cash = $("#modifyCash").val();
    const card = $("#modifyCard").val();
    const vaultCash = $("#modifyVaultCash").val();
    const data = {id, cash, card, vaultCash};

    $.ajax("/Revenue/modifyDaily", {
        method: "put",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function () {
            window.location.href = "/Revenue/daily";
        }
    })
})

//일일 정산 삭제 과정
$(".deleteBtn").click(function () {
    //삭제버튼을 누르면
    const settlementId = $(this).attr("settlement-id");
    $("#settlementIdInput").val(settlementId);
    const dateInfo = $("#dateLink"+settlementId).text();
    console.log(dateInfo);
    $("#deleteDayBox").text(dateInfo);

    $("#deleteModalBtn").click(function () {
        //모달 삭제 버튼을 누르면
        $.ajax("/Revenue/deleteDaily?settlementId=" + settlementId, {
            method: "delete",
            success: function () {
                window.location.href = "/Revenue/daily";
            }
        })
    })
})

//조건 조회 기간별, 월별 기능 추가
//기간을 선택하면 월별 선택 불가능, 월별을 선택하면 기간 선택 불가능
var monthInput = document.getElementById('monthInput');
var startDateInput = document.getElementById('startDateInput');
var endDateInput = document.getElementById('endDateInput');

monthInput.addEventListener('change', function () {
    //월별 조회를 선택할 경우 시작일과 종료일의 값은 없어지고 disabled된다
    startDateInput.disabled = true;
    endDateInput.disabled = true;
    startDateInput.value='';
    endDateInput.value='';
    alert('월별 조회를 선택한 경우 기간별 조회를 할 수 없습니다.');
});

startDateInput.addEventListener('change', function () {
    //시작일을 선택할 경우 월별 조회의 값은 없어지고 disable된다.
    monthInput.disabled = true;
    monthInput.value='';
    alert('기간별 조회를 선택하시면 월별 조회를 선택할 수 없습니다.');
});


