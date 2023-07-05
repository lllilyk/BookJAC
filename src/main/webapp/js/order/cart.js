/* 수량 버튼 조작 */
let quantity = $("#quantity_input").val();
/* +버튼으로 수량 조작 */
$("#plus_btn").on("click", function(){
    $("#quantity_input").val(++quantity);
});
/* -버튼으로 수량 조작 */
$("#minus_btn").on("click", function (){
    /* 수량이 1보다 큰 경우에만 동작 */
    if(quantity > 1){
        $("#quantity_input").val(--quantity);
    }
});

/* 서버로 전송할 데이터 */
const bookId = $("#bookIdText").text().trim();
const bookCount = '';
const form = {bookId, bookCount};

/* 발주 품목 등록 버튼 */
$("#btn_cart").on("click", function (e){
    form.bookCount = $("#quantity_input").val();
    $.ajax({
        url: '/cart/add',
        type: 'POST',
        data: form,
        success: function(result){
            if(result == '0'){
                alert("발주 품목에 추가하지 못하였습니다.");
            } else if(result == '1'){
                alert("발주 품목에 추가되었습니다.");
            } else if(result == '2'){
                alert("발주 품목에 이미 추가되어 있습니다.");
            }
        }
    })
})