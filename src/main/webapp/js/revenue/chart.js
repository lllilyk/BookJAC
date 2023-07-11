// 바 차트 보기 버튼 클릭 시
$("#barChartBtn").click(function () {
    $("#barChartBox").toggleClass("d-none");
    $("#chartSelectWay").text(function () {
        let selectWay = $(this).attr("select-way");
        console.log(selectWay);
        if (selectWay == 1) {
            return '(현금 매출)'
        } else if (selectWay == 2) {
            return '(카드 매출)'
        } else if (selectWay == 3 || selectWay == null || selectWay == 0) {
            return ''
        }
    });
    // 바 차트 코드
    const barChart = document.getElementById('barChartCanvas');

    new Chart(barChart, {
        data: {
            datasets: [{
                type: 'bar',
                data: xInfo[1],
                order: 2,
                label: '총 수입트'
            }, {
                type: 'line',
                data: xInfo[1],
                order: 1,
                label: '순수익'
            }],
            labels: xInfo[0]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
})

//도넛 차트 보기 버튼 클릭 시
$("#doughnutChartBtn").click(function () {
    $("#doughnutChartBox").toggleClass("d-none");

    //도넛 차트 코드
    const doughnutChart = document.getElementById('doughnutChartCanvas');

    new Chart(doughnutChart, {
        type: 'doughnut',
        data: {
            labels: ['발주 합계', '순이익 합계'],
            datasets: [{
                label: label,
                data: [orderSum, inPriceSum],
                backgroundColor: [
                    'rgb(255, 99, 132)',
                    'rgb(54, 162, 235)',
                    'rgb(255, 205, 86)'
                ],
                hoverOffset: 4
            }]
        }
    });
})



