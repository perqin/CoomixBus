var urlprefix = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?";
var stationBusList = new Array();
var historyList = new Array();
var historyListString = "[]";
/*var allList, filterList;
var searchList = new Array();
var historyList = new Array();
var historyListString = "[]";
var cityList;
var cityNameList = new Array();
var u_citycode;
var o_alllines = new Array();
var o_linelist;
var o_temp = new Object();


function checkPre(s, p){
    var b = true;
    for(var i = 0; i < p.length; i++){
        if(s[i] != p[i]){
            b = false;
        }
    }
    return b;
}

function parseJson(t,j){
    if(t=="all"){
        for(var i=0; i<o_linelist.length; i++){
            o_alllines[i] = JSON.parse(o_linelist[i]);
            console.log(o_alllines[i].name)
        }
    }else if(t=="note"){
        o_temp=JSON.parse(j);
    }
}

function filterIt(pre){
    var tem_arr = new Array();
    var tem_c = -1;
    for(var i=0; i<o_alllines.length; i++){
        //console.log(o_alllines[i].name);
        if(checkPre(o_alllines[i].name, pre)){
            tem_c += 1;
            tem_arr[tem_c] = o_alllines[i];
            //console.log("ok");
        }else{
            //console.log("no");
        }
    }
    return tem_arr;
}

function getCityName(code){
    for(var i=0;i<cityList.length;i++){
        if(cityList[i].code==code){ return cityList[i].name; }
    }
}

function initCities(s){
    console.log(s);
    var o=JSON.parse(s);
    if(o.success=="true"){
        cityList=o.data;
        cityNameList.splice(0, cityNameList.length);
        for(var i=0;i<cityList.length;i++){
            cityNameList[i] = cityList[i].name;
            console.log(o.data[i].name+" : "+o.data[i].code);
        }
        return true;
    }else{
        return false;
    }
}
*/
/*
function setHistoryList() {
    historyList = JSON.parse(historyListString);
}

function appendHistory(obje) {
    if(historyList.length == 0) {
        historyList.push(obje);
    }else{
        var booHaved = false;
        for(var i = 0; i < historyList.length; i++) {
            if(historyList[i].station_name == obje.station_name) {
                booHaved = true;
                console.log("booTrue");
                break;
            }
        }
        if(booHaved == false){
            console.log("booFalse");
            historyList.push(obje);
        }
    }
    historyListString = JSON.stringify(historyList);
    console.log(historyListString);
}*/

function setHistoryList(s) {
    historyListString = s;
    historyList = JSON.parse(historyListString);
}

function appendHistory(obje) {
    if(historyList.length == 0) {
        historyList.push(obje);
    }else{
        var booHaved = false;
        for(var i = 0; i < historyList.length; i++) {
            if(historyList[i].station_name == obje.station_name) {
                booHaved = true;
                //console.log("booTrue");
                break;
            }
        }
        if(booHaved == false){
            //console.log("booFalse");
            historyList.push(obje);
        }
    }
    historyListString = JSON.stringify(historyList);
    //console.log(historyListString);
}

function makeModelData(d, es, id, io, n, o, ss, st) {
    var md = new Object();
    md.direction = d;
    md.end_station = es;
    md.id = id;
    md.isopen = io;
    md.name = n;
    md.original_name = o;
    md.start_station = ss;
    md.service_time = st;
    return md;
}

function parseIt(d) {
    var o = JSON.parse(d);
    stationBusList = o.data;
    //for(var k = 0; k < o.data.length; k++){console.log(o.data[k].station_name + "///");}
}

function getUrl(cc, sn){
    //method=get_line_by_station&station_name=富地岗&citycode=860515
    var url="";
    url=urlprefix+"method=get_line_by_station&station_name=" + sn + "&citycode=" + cc;
    return url;
}

function dtc(d){
    return d;
}
