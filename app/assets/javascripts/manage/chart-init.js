//= require morris-chart/morris
//= require morris-chart/raphael-min
// = require flot-chart/jquery.flot.min
//= require flot-chart/jquery.flot.tooltip.min
//= require flot-chart/jquery.flot.resize.min

$(function(){
    $.ajax({
        url: '/manage/products_count',
        type: 'get',
        dataType: 'json',
        success: function(res) {
            build_chart(res);
        },
        error: function() {

        }
    })
    function build_chart(data) {
        var yp_count = data.yp_count,
            lx_count = data.lx_count,
            jk_count = data.jk_count,
            ky_count = data.ky_count,
            yl_count = data.yl_count,
            qt_count = data.qt_count,
            total_count = 0;

            for(var i in data) {
                total_count += data[i];
            }

        // Use Morris.Area instead of Morris.Line
        Morris.Donut({
            element: 'graph-donut',
            data: [
                {value: yp_count, label: '语言培训', formatted: '总数 ' + yp_count },
                {value: lx_count, label: '留学中介', formatted: '总数 ' + lx_count },
                {value: ky_count, label: '考研课程', formatted: '总数 ' + ky_count },
                {value: jk_count, label: '驾校学车', formatted: '总数 ' + jk_count },
                {value: yl_count, label: '生活娱乐', formatted: '总数 ' + yl_count },
                {value: qt_count, label: '其它', formatted: '总数 ' + qt_count }
            ],
            backgroundColor: false,
            labelColor: '#fff',
            colors: [
                '#5ab6df','#4bccae','#6a8bbe','#fb8575', '#febd48', '#c5c5c5'
            ],
            formatter: function (x, data) { return data.formatted; }
        });
    }
})

$(function() {

    $.ajax({
        url: '/manage/viewers_count',
        type: 'get',
        dataType: 'JSON',
        success: function(res) {
            build_v_chart(res);
        },
        error: function() {

        }
    })
    function build_v_chart(data) {

        var d1 = [
            [1, data.v_7_count],
            [2, data.v_6_count],
            [3, data.v_5_count],
            [4, data.v_4_count],
            [5, data.v_3_count],
            [6, data.v_2_count],
            [7, data.v_1_count]
        ];
        // var d2 = [
        //     [0, 401],
        //     [1, 520],
        //     [2, 337],
        //     [3, 261],
        //     [4, 449],
        //     [5, 518],
        //     [6, 470],
        //     [7, 658],
        //     [8, 558],
        //     [9, 438],
        //     [10, 388]
        // ];

        var data = ([{
            label: "产品浏览次数",
            data: d1,
            lines: {
                show: true,
                fill: true,
                fillColor: {
                    colors: ["rgba(255,255,255,.4)", "rgba(183,236,240,.4)"]
                }
            }
        }
        // ,
        //     {
        //         label: "未登录用户",
        //         data: d2,
        //         lines: {
        //             show: true,
        //             fill: true,
        //             fillColor: {
        //                 colors: ["rgba(255,255,255,.0)", "rgba(253,96,91,.7)"]
        //             }
        //         }
        //     }
        ]);

        var options = {
            grid: {
                backgroundColor:
                {
                    colors: ["#ffffff", "#f4f4f6"]
                },
                hoverable: true,
                clickable: true,
                tickColor: "#eeeeee",
                borderWidth: 1,
                borderColor: "#eeeeee"
            },
            // Tooltip
            tooltip: true,
            tooltipOpts: {
                content: "%s: %x %y次",
                shifts: {
                    x: -60,
                    y: 25
                },
                defaultTheme: false
            },
            legend: {
                labelBoxBorderColor: "#000000",
                container: $("#main-chart-legend"), //remove to show in the chart
                noColumns: 0
            },
            xaxis: {
                tickSize: 1,
                tickFormatter: function(v, axis) { console.log(axis);return '前' + (8-v) + '天' }
            },
            yaxis: {
                // tickFormatter: function(v, axis) { return v + '人' }
                min: 0
            },
            series: {
                stack: true,
                shadowSize: 0,
                highlightColor: 'rgba(000,000,000,.2)'
            },
           lines: {
               show: true,
               fill: true

           },
            points: {
                show: true,
                radius: 3,
                symbol: "circle"
            },
            colors: ["#5abcdf", "#ff8673"]
        };
        var plot = $.plot($("#main-chart #main-chart-container"), data, options);
    }

});
