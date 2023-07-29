const toastElement = document.querySelector("#liveToast")
const toast = bootstrap.Toast.getOrCreateInstance(toastElement);

$(document).ready(function() {
    /* 납기 일자 */
    // currentDate를 JS Date 객체로 변환
    var currentDateJS = new Date(currentDate);
    // 7일을 더한 날짜 계산
    var deadline = new Date(currentDateJS.getTime());
    deadline.setDate(deadline.getDate() + 7);
    // 납기일자 표시
    var formattedDueDate = deadline.toISOString().slice(0, 10);
    document.getElementById('deadline').innerText = formattedDueDate;
});

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
});

/* 수량 버튼 조작 */
const maxQuantity = 100; // 최대 허용 수량 설정
// +버튼으로 수량 조작
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
// -버튼으로 수량 조작
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
        data.title = $(this).closest("tr").find(".title").text().trim();
        data.writer = $(this).closest("tr").find(".writer").text();
        data.publisher = $(this).closest("tr").find(".publisher").text().trim();
        data.inPrice = $(this).closest("tr").find(".inPrice").text().trim();
        /* 서버로 데이터 전송 */
        $.ajax({
            url: '/cart/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
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

function formatCurrency(number) {
    const formatter = new Intl.NumberFormat('ko-KR', {
        style: 'currency',
        currency: 'KRW',
    });
    return formatter.format(number);
}
/* 발주 품목 수량 수정 버튼 */
$(".changeBtn").on("click", function(e) {
    e.preventDefault(); // 기본 클릭 동작(페이지 이동 등)을 방지

    let index = $(this).attr("id").split("_")[2];
    let quantity = parseInt($(this).closest("tr").find("input#quantity_input_" + index).val());
    let cartId = parseInt($(this).closest("tr").find("button#btn_cart_" + index).val());

    if (quantity <= maxQuantity) {
        $(".update_cartId").val(cartId);
        $(".update_bookCount").val(quantity);

        /* 서버로 데이터 전송 */
        $.ajax({
            url: '/cart/update',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({cartId: cartId, bookCount: quantity}),
            success: function (response) {
                // 응답 데이터 확인
                if (response.result === 'success') {
                    // 합계 금액 업데이트
                    let inPriceSum = response.inPriceSum;
                    let inPriceSumEach = document.getElementById("inPriceSum_" + index);
                    inPriceSumEach.innerText = formatCurrency(inPriceSum);

                    // 총 발주 품목 수량 업데이트
                    let totalQuantity = document.getElementById("totalQuantity");
                    totalQuantity.innerText = "총 발주 품목 수량: " + response.totalQuantity;

                    // 총 결제 예상 금액 업데이트
                    let totalPrice = document.getElementById("totalPrice");
                    totalPrice.innerText = "총 결제 예상 금액: " + formatCurrency(response.totalPrice);

                    cartChangeAlert('1'); // 성공적으로 변경되었다는 메시지 출력
                } else {
                    cartChangeAlert('0'); // 실패 메시지 출력
                }
            }
        })
    } else {
        alert("유효한 수량 값을 입력해주세요");
    }
});

function cartChangeAlert(change){
    if(change == '0'){
        alert("수량 변경에 실패하였습니다.");
    } else if(change == '1'){
        alert("수량이 변경되었습니다.");
    }
}

/* 발주 품목 삭제 버튼 */
$(".btn_delete_cart").on("click", function(e) {
    e.preventDefault(); // 기본 클릭 동작(페이지 이동 등)을 방지
    let index = $(this).attr("id").split("_")[2];
    let cartId = parseInt($(this).closest("tr").find("button#btn_cart_" + index).val());
    let cartRow = $(this).closest("tr");
    /* 삭제 폼에 해당 cartId를 설정*/
    $(".delete_cartId").val(cartId);

    /* 서버로 데이터 전송 */
    $.ajax({
        url: '/cart/delete/' + cartId,
        type: 'DELETE',
        success: function(responseD){
            // 응답 데이터 확인
            if (responseD.result === 'success') {
                cartRow.remove();
                /* 성공적으로 삭제된 경우 해당 행을 테이블에서 제거 */
                cartDeleteAlert(responseD.result); // 성공적으로 변경되었다는 메시지 출력

                // 총 발주 품목 수량 업데이트
                let totalQuantity = document.getElementById("totalQuantity");
                totalQuantity.innerText = "총 발주 품목 수량: " + responseD.totalQuantity;

                // 총 결제 예상 금액 업데이트
                let totalPrice = document.getElementById("totalPrice");
                totalPrice.innerText = "총 결제 예상 금액: " + formatCurrency(responseD.totalPrice);
            }
        }
    })
});

function cartDeleteAlert(result){
    if(result == 'fail'){
        alert("발주 품목에서 삭제하지 못하였습니다.");
    } else if(result == 'success'){
        alert("발주 품목에서 삭제되었습니다.");

    }
}

/* 발주하기 버튼 클릭시의 발주확인 modal */
$(document).ready(function () {
    $(".addOrderDetails").on("click", function () {
        $(".orderConfirmModal").modal("show");
    });
});

/* 발주확인 modal 내의 '이대로 발주할게요'버튼을 눌렀을 때 */
$(document).ready(function() {
    $(".addOrderDetailsBtn").on("click", function() {
        // currentDate를 JS Date 객체로 변환
        var currentDateJS = new Date(currentDate);

        // currentDateJS를 hidden input으로 폼에 추가
        var hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'currentDateJS';
        hiddenInput.value = currentDateJS.toISOString();
        document.getElementById('orderProcessForm').appendChild(hiddenInput);
        // inserted 값을 설정
        var insertedInput = document.getElementsByName('inserted')[0];
        insertedInput.value = currentDate; // currentDate 값을 설정
    });
});

/* 도서 검색 */
document.getElementById("bookSearchForm").addEventListener("submit", function(event) {
    event.preventDefault(); // 기본적인 폼 제출 동작 방지

    // 입력 필드의 값 가져오기
    var searchText = document.getElementById("searchBook").value;

    // 검색어를 포함한 URL 생성
    var url = "/order/search?text=" + encodeURIComponent(searchText);

    // 새로운 URL로 페이지 이동
    window.location.href = url;
});