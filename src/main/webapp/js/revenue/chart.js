
// 바 차트 보기 버튼 클릭 시
$("#barChartBtn").click(function () {
    $("#barChartBox").toggleClass("d-none");
})

//도넛 차트 보기 버튼 클릭 시
$("#doughnutChartBtn").click(function () {
    $("#doughnutChartBox").toggleClass("d-none");
})

// 바 차트 코드
const barChart = document.getElementById('barChartCanvas');

new Chart(barChart, {
    data: {
        datasets: [{
            type: 'bar',
            data: xInfo[1],
            order: 2,
            label: '막대 이름'
        }, {
            type: 'line',
            data: xInfo[1],
            order: 1,
            label: '선 이름음'
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

//도넛 차트 코드
const doughnutChart = document.getElementById('doughnutChartCanvas');

new Chart(doughnutChart, {
    type: 'doughnut',
    data: {
        labels: ['Red', 'Blue', 'Yellow'],
        datasets: [{
            label: 'My First Dataset',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)'
            ],
            hoverOffset: 4
        }]
    }
});