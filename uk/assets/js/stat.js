var txt = '{"release":["2019 Q3"],"stat1":[0.32],"stat2":[-1.7]}';
var obj = JSON.parse(txt);
document.getElementById("js-release").innerHTML = "Release: <br>" + obj.release;
document.getElementById("js-stat1").innerHTML = obj.stat1 + " %";
document.getElementById("js-stat2").innerHTML = obj.stat2 + " %";
