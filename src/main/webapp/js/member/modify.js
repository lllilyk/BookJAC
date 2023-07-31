// 이메일 중복확인 버튼 클릭 시
$("#checkEmailBtn").click(function () {
    const email = $("inputEmail").val();
    $.ajax("/member/checkEmail/" + email, {
       success: function (data) {
           if (data.available) {
               // 사용 가능하다는 메세지 출력
               $("#availableEmailMessage").removeClass("d-none");
               $("#notAvailableEmailMessage").addClass("d-none");

               // 중복확인 되었다는 표시
           } else {
               // 사용 불가능하다는 메세지 출력
               $("#availableEmailMessage").addClass("d-none");
               $("#notAvailableEmailMessage").removeClass("d-none");

               // 중복확인 안되었다는 표시
           }
       },
        // 수정버튼 활성화 or 비활성화

    });
});

$("#inputPassword, #inputPasswordCheck").keyup(function () {
    const pw1 = $("#inputPassword").val();
    const pw2 = $("#inputPasswordCheck").val();

    if (pw1 === pw2) {
        $("#modifyButton").removeClass("disabled");
        $("#passwordSuccessText").removeClass("d-none");
        $("#passwordFailText").addClass("d-none");
    } else {
        $("#modifyButton").addClass("disabled");
        $("#passwordSuccessText").addClass("d-none");
        $("#passwordFailText").removeClass("d-none");
    }
})