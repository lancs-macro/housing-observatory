(function () {

    var chart = c3.generate({
        bindto: d3.select('.chart-mobile'),
        data: {
            url: 'prices.csv',
            x: 'date',
            colors: {
                UK: '#992f2f',
                Aggregate: '#314658'
            }
            //onmouseover: onMouseover,
            /*columns: [
                ['date', '2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04', '2013-01-05', '2013-01-06'],
                ['data1', 30, 200, 100, 400, 150, 250],
                ['data2', 130, 340, 200, 500, 250, 350]
            ]*/
        },
        size: {
            height: 550
        },
        padding: {
            left: 23,
            right: 0
        },
        legend: {
            hide: false,
            position: 'bottom'
        },
        point: {
            show: false
        },
        grid: {
            y: {
                show: true
            },
            x: {
                lines: [
                    { value: "2005-01-01", text: 'Base Year' },
                ]
            }
        },
        axis: {
            x: {
                type: 'timeseries',
                tick: {
                    fit: true,
                    format: '%Y-Q%q',
                    count: 5
                }

            },
            y: {
                tick: {
                    values: [0, 30, 60, 90, 120, 150, 180, 210],
                    rotate: 90
                },
                label: {
                    text: 'House Prices',
                    position: 'inner-top',
                }
            }
        }
    });

    chart.hide(["Australia", "Belgium", "Canada", "Switzerland", "Germany", "Denmark", "Spain",
        "Finland", "France", "Ireland", "Italy", "Japan", "S. Korea", "Luxembourg", "Netherlands",
        "Norway", "New Zealand", "Sweden", "S. Africa", "Croatia", "Israel"], { withLegend: true })

})();