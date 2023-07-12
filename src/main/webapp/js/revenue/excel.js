//엑셀 다운로드 코드

document.getElementById("excelBtn").addEventListener('click', function () {
    var wb = XLSX.utils.book_new(); // 빈 워크북 생성

    // 첫 번째 테이블
    var table1 = document.getElementById("TableToExport");
    var ws1 = XLSX.utils.table_to_sheet(table1);
    XLSX.utils.book_append_sheet(wb, ws1, "테이블1");

    // 두 번째 테이블
    var table2 = document.getElementById("TableToExport1");
    if (table2) {
        var ws2 = XLSX.utils.table_to_sheet(table2);
        XLSX.utils.book_append_sheet(wb, ws2, "테이블2");
    }

    var title = $("#title").text();
    XLSX.writeFile(wb, title + ".xlsx");
});

