var txt = '{"name":"John", "age":30, "city":"New York"}'

import { readFileSync } from 'fs';
var data = readFileSync("stat-data.json", "utf8");
var data1 = JSON.parse(data);
var obj = JSON.parse(txt);
document.getElementById("stat1").innerHTML = obj.name + ", " + obj.age;
document.getElementById("stat2").innerHTML = data1.name + ", " + data1.age;