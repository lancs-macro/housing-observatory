
var chart = c3.generate({
    bindto: d3.select('#chart-mobile2'),
    data: {
        url: '/data/growth.csv',
        x: 'date',
        colors: {
            UK: '#992f2f',
            Aggregate: '#314658'
        },
        type: 'line',
        line: {
            title: 'House Price Level' 
        }
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
                values: [-30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30],
                rotate: 90
            },
            label: {
                text: 'YoY House Price Growth (%)',
                position: 'inner-middle',
            }
        }
    }
});

chart.hide(["Australia", "Belgium", "Canada", "Switzerland", "Germany", "Denmark", "Spain",
    "Finland", "France", "Ireland", "Italy", "Japan", "S. Korea", "Luxembourg", "Netherlands",
    "Norway", "New Zealand", "Sweden", "S. Africa", "Croatia", "Israel", "Colombia","Slovenia"], { withLegend: true })

