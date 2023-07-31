// 중복확인 후 가입버튼 활성화를 위한 변수 선언
let checkId = false;
let checkEmail = false;
let checkPhoneNumber = false;
let checkPassword = false;

// 중복확인 시 모두 사용 가능한 값이면 가입버튼 활성화, 그렇지 않으면 비활성화
function enableSubmit() {
    console.log(checkId, checkPassword, checkEmail, checkPhoneNumber);

    if (checkId && checkEmail && checkPhoneNumber && checkPassword ) {
        $("#signupSubmit").removeAttr("disabled");
    } else {
        $("#signupSubmit").attr("disabled", "");
    }
}

// 아이디 input에 키보드 입력 발생 시
$("#inputId").keyup(function () {
   // 아이디 중복 확인 다시
   checkId = false;
   $("#availableIdMessage").addClass("d-none");
   $("#notAvailableMessage").addClass("d-none");

   // submit 버튼 비활성화
    enableSubmit();
});

// id 중복확인 버튼이 클릭되면
$("#checkIdBtn").click(function () {
    const userid = $("#inputId").val();
    // 입력한 id와 ajax 요청 보내서
    $.ajax("/member/checkId/" + userid, {
        success: function (data) {
            //`{"available": true}`

            if (data.available) {
                // 사용 가능하다는 메세지 출력
                $("#availableIdMessage").removeClass("d-none");
                $("#notAvailableMessage").addClass("d-none");
                checkId = true;
            } else {
                // 사용 불가능하다는 메세지 출력
                $("#availableIdMessage").addClass("d-none");
                $("#notAvailableMessage").removeClass("d-none");
                checkId = false;
            }
        },
        complete: enableSubmit
    })
});

// email input에 키보드 입력 발생 시
$("#inputEmail").keyup(function () {
   // email 중복 다시 확인
   checkEmail = false;
   $("#availableEmailMessage").addClass("d-none");
   $("#notAvailableEmailMessage").addClass("d-none");

   // submit 버튼 비활성화
    enableSubmit();
});

// email 중복확인 버튼이 클릭되면
$("#checkEmailBtn").click(function () {
    const email = $("#inputEmail").val();

    $.ajax("/member/checkEmail/" + email, {
        success: function (data) {

            if (data.available) {
                $("#availableEmailMessage").removeClass("d-none");
                $("#notAvailableEmailMessage").addClass("d-none");
                checkEmail = true;
            } else {
                $("#availableEmailMessage").addClass("d-none");
                $("#notAvailableEmailMessage").removeClass("d-none");
                checkEmail = false;
            }
        },
        complete: enableSubmit
    })
});

// 전화번호 input에 키보드 입력 발생 시
$("#inputPhoneNum").keyup(function () {
   // 전화번호 중복 다시 확인
   checkPhoneNumber = false;
   $("#availablePhoneNumberMessage").addClass("d-none");
   $("#notAvailablePhoneNumberMessage").addClass("d-none");

   // submit 버튼 비활성화
    enableSubmit();
});

// 전화번호 중복확인 버튼이 클릭되면
$("#checkPhoneNumberBtn").click(function () {
   const phoneNumber = $("#inputPhoneNum").val();

   $.ajax("/member/checkPhoneNumber/" + phoneNumber, {
       success: function (data) {

           if (data.available) {
               $("#availablePhoneNumberMessage").removeClass("d-none");
               $("#notAvailablePhoneNumberMessage").addClass("d-none");
               checkPhoneNumber = true;
           } else {
               $("#availablePhoneNumberMessage").addClass("d-none");
               $("#notAvailablePhoneNumberMessage").removeClass("d-none");
               checkPhoneNumber = false;
           }
       },
       complete: function() {
           enableSubmit();
       }
   })
});

// 패스워드, 패스워드 체크 인풋에 키업 이벤트가 발생하면
$("#inputPW, #inputPWCheck").keyup(function () {
    // 패스워드에 입력한 값
    const pw1 = $("#inputPW").val();
    // 패스워드 확인에 입력한 값
    const pw2 = $("#inputPWCheck").val();
    // 패스워드 확인 시 일치하면
    if (pw1 === pw2) {
        // submit 버튼 활성화
        $("#signupSubmit").removeAttr("disabled");
        // 패스워드가 같다는 메세지 출력
        $("#passwordSuccessText").removeClass("d-none");
        $("#passwordFailText").addClass("d-none");
        checkPassword = true;
    }
    // 그렇지 않으면 submit 버튼 비활성화
    else {
        $("#signupSubmit").attr("disabled", "");
        // 패스워드가 다르다는 메세지 출력
        $("#passwordFailText").removeClass("d-none");
        $("#passwordSuccessText").addClass("d-none");
        checkPassword = false;
    }
    enableSubmit();
});