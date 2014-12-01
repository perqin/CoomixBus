var urlprefix = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?";
var searchList = new Array();
var historyList = new Array();
var nearbyList = new Array();
var historyListString = "[]";
/*var allList, filterList;
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

function setHistoryList(s) {
    console.log("lllll");
    console.log(s);
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

function parseIt(d) {
    var o = JSON.parse(d);
    searchList = o.data;
    //for(var k = 0; k < o.data.length; k++){console.log(o.data[k].station_name + "///");}
}

function parseNearby(d) {
    var o = JSON.parse(d);
    nearbyList = o.data;
}

function getUrl(cc, sn){
    //method=getmatchedstations&citycode=860515&mapType=G_NORMAL_MAP&cn=gm&stationname=%E6%B7%B1%E5%9C%B3
    var url="";
    url=urlprefix+"method=getmatchedstations&citycode=" + cc + "&mapType=G_NORMAL_MAP&cn=gm&stationname=" + sn;
    //url=urlprefix+"method=getmatchedstations&citycode=" + cc + "&mapType=G_NORMAL_MAP&cn=gm&stationname=" + encodeURI(sn);
    return url;
}

function getUrlNearby(lat, lng, cc) {
    var url = "";
    url = urlprefix + "method=get_station_refpos&lng=" + lng + "&lat=" + lat + "&mapType=BAIDU_MAP&posmaptype=BAIDU_MAP&citycode=" + cc;
    return url;
}

function dtc(d){
    return d;
}
