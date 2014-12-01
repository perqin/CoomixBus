var obj;
var q_origin, q_destination;

function getUrl(o, d) {
    return "http://api.go2map.com/engine/api/bus/json?destination=" + d + "&origin=" + o + "&avoid=0&tactic=8&maxresultcount=10&contenttype=UTF-8";
}

function parseIt(j) {
    obj = JSON.parse(j);
    console.log("parse ok!");
}
