$(document).ready(function() {
    /* 납기 일자 */
    // inserted를 JS Date 객체로 변환
    var currentDateJS = new Date(orderCartJson);
    // 7일을 더한 날짜 계산
    var deadline = new Date(currentDateJS.getTime());
    deadline.setDate(deadline.getDate() + 7);
    // 납기일자 표시
    var formattedDueDate = deadline.toISOString().slice(0, 10);
    document.getElementById('deadline').innerText = formattedDueDate;
});