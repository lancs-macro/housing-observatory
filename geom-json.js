var figure = JSON.parse("data.json");
Plotly.newPlot('graph-div', figure.data, figure.layout);