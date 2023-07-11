//엑셀 다운로드 코드
document.getElementById("excelBtn").addEventListener('click', function () {
    var wb = XLSX.utils.table_to_book(document.getElementById("TableToExport"));
    var title = $("#title").text();
    XLSX.writeFile(wb, title + ".xlsx");
});

