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
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        yearSuffix: '년',
        changeMonth: true,
        changeYear: true
    }
    $(".checkDate").datepicker(config);
});

// 검색 버튼 클릭 이벤트 처리
$(".dateBtn").click(function(event) {
    event.preventDefault();
    const selectedDate = $("#searchByDate").val();

    // 페이지 번호를 1로 초기화하여 첫 번째 페이지에서 검색 결과를 보여주기 위함
    const page = 1;

    // 새로운 URL을 만들어서 페이지 이동
    const newUrl = `/order/details?search=${selectedDate}&page=${page}`;
    window.location.href = newUrl;
});

