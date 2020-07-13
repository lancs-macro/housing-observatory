var chart = c3.generate({
    bindto: d3.select('#chart'),
    data: {
        url: '/data/level.csv',
        x: 'date',
        colors: {
            UK: '#992f2f',
            Aggregate: '#314658'
        }
    },
    size: {
        height: 550
    },
    padding: {
        right: 220,
        bottom: 48
    },
    legend: {
        hide: false,
        position: 'right'
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
                count: 15
            }

        },
        y: {
            tick: {
                values: [0, 30, 60, 90, 120, 150, 180, 210]
            },
            label: {
                text: 'House Price Level',
                position: 'outer-middle'
            }
        }
    }
});

chart.hide(["Australia", "Belgium", "Canada", "Switzerland", "Germany", "Denmark", "Spain",
    "Finland", "France", "Ireland", "Italy", "Japan", "S. Korea", "Luxembourg", "Netherlands",
    "Norway", "New Zealand", "Sweden", "S. Africa", "Croatia", "Israel", "Slovenia"], { withLegend: true })

