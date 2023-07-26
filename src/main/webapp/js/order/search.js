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
        data.bookId = $("#bookIsbnText_" + index).text().trim();
        data.bookCount = quantity;
        data.title = $(this).closest("tr").find(".title").text().trim();
        data.publisher = $(this).closest("tr").find(".publisher").text().trim();
        data.inPrice = $(this).closest("tr").find(".inPrice").text().trim();
        /* 서버로 데이터 전송 */
        $.ajax({
            url: '/cart/add',
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
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