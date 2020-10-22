
var chart = c3.generate({
    bindto: d3.select('#chart-mobile'),
    data: {
        url: '/data/level.csv',
        x: 'date',
        colors: {
            UK: '#992f2f',
            Aggregate: '#314658'
        },
        type: 'line'
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
        // x: {
        //     lines: [
        //         { value: "2005-01-01", text: 'Base Year' },
        //     ]
        // }
    },
    axis: {
        x: {
            type: 'timeseries',
            tick: {
                fit: true,
                format: '%Y-Q%q',
                count: 5
            },
            label: {
                text: 'Base Year = 2005',
                position: 'inner-right'
            }

        },
        y: {
            tick: {
                values: [0, 30, 60, 90, 120, 150, 180, 210],
                rotate: 90
            },
            label: {
                text: 'House Price Level',
                position: 'inner-middle',
            }
        }
    }
});


chart.hide(["Australia", "Belgium", "Canada", "Switzerland", "Germany", "Denmark", "Spain",
    "Finland", "France", "Ireland", "Italy", "Japan", "S. Korea", "Luxembourg", "Netherlands",
    "Norway", "New Zealand", "Sweden", "S. Africa", "Croatia", "Israel", "Colombia","Slovenia"], { withLegend: true })
