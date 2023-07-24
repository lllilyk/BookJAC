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
$(document).ready(function(){
    $(".checkDate").datepicker(config);
});

/*도서 검색*/
document.getElementById("bookSearchForm").addEventListener("submit", function(event) {
    event.preventDefault(); // 기본적인 폼 제출 동작 방지

    // 입력 필드의 값 가져오기
    var searchText = document.getElementById("searchBook").value;

    // 검색어를 포함한 URL 생성
    var url = "/order/search?text=" + encodeURIComponent(searchText);

    // 새로운 URL로 페이지 이동
    window.location.href = url;
});
/* 수량 버튼 조작 */
const maxQuantity = 100; // 최대 허용 수량 설정

/* +버튼으로 수량 조작 */
$(".plus_btn").on("click", function(){
    let index = $(this).attr("id").split("_")[2];
    let quantityField = $("#quantity_input_" + index);
    let quantity = parseInt(quantityField.val());

    if(quantity < maxQuantity){
        quantityField.val(++quantity);
    } else {
        quantityField.val(1);
    }
});

/* -버튼으로 수량 조작 */
$(".minus_btn").on("click", function (){
    let index = $(this).attr("id").split("_")[2];
    let quantityField = $("#quantity_input_" + index);
    let quantity = parseInt(quantityField.val());

    if(quantity > 1){
        quantityField.val(--quantity);
    } else {
        quantityField.val(1);
    }
});

/* 발주 품목 등록 버튼 */
$(".btn_cart").on("click", function(e) {
    const data = {};
    let index = $(this).attr("id").split("_")[2];
    let quantity = parseInt($(this).closest("tr").find("input#quantity_input_" + index).val());

    if (quantity <= maxQuantity) {
        data.bookId = $("#bookIdText_" + index).text().trim();
        data.bookCount = quantity;
        /* 서버로 데이터 전송 */
        $.ajax({
            url: '/cart/add',
            type: 'POST',
            data: data,
            success: function (result) {
                cartAlert(result);
            }
        });
    } else {
        alert("유효한 수량 값을 입력해주세요.");
    }
});

function cartAlert(result){
    if(result == '0'){
        alert("발주 품목에 추가하지 못하였습니다.");
    } else if(result == '1'){
        alert("발주 품목에 추가되었습니다.");
    } else if(result == '2'){
        alert("발주 품목에 이미 추가되어 있습니다.");
    }
}


