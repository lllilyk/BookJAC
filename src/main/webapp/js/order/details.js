$(document).ready(function() {
    /* 캘린더 위젯 적용*/
    const config = {
        dateFormat: 'yy-mm-dd',
        showOn: "button",
        buttonText: "날짜 선택",
        showButtonPanel: true,
        currentText: "오늘",
        closeText: "닫기",
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        yearSuffix: '년',
        changeMonth: true,
        changeYear: true
    }
    $(".checkDate").datepicker(config);

    // 검색 버튼 클릭 이벤트 처리
    $(".dateBtn").click(function() {
        // 발주일자 입력값 가져오기
        const selectedDate = $(".checkDate").val();

        // 테이블의 모든 행 숨기기
        $("table.table tbody tr").hide();

        // 입력된 발주일자와 동일한 inserted 값을 가진 행 표시
        $("table.table tbody tr:contains('" + selectedDate + "')").show();
    });
});