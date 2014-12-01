var allList, filterList;
var historyList = new Array();
var historyListString = "[]";
/*var cityList = [{"name":"深圳","code":"860515"},
                {"name":"惠州","code":"860506"},
                {"name":"西安","code":"862307"},
                {"name":"北京","code":"860201"}];*/
//var cityList = new Array();
var cityList;
var cityNameList = new Array();
var urlprefix = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?";
var u_citycode;
var o_alllines = new Array();
var o_linelist;
var o_temp = new Object();

function setHistoryList(s) {
    console.log("kkk");
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
            if(historyList[i].id == obje.id) {
                booHaved = true;
                break;
            }
            if(booHaved == false){
                historyList.push(obje);
            }
        }
    }
    historyListString = JSON.stringify(historyList);
}

function checkPre(s, p){
    var b;
    for (var j = 0; j <= s.length - p.length; j++) {
        b = true;
        for(var i = 0; i < p.length; i++){
            if(s[i + j] != p[i]){
                b = false;
                break;
            }
        }
        if(b)
            return true;
    }
    return false;
}

function parseJson(t,j){
    if(t=="all"){
        for(var i=0; i<o_linelist.length; i++){
            o_alllines[i] = JSON.parse(o_linelist[i]);
            //console.log(o_alllines[i].name)
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
            console.log(o_alllines[i].name);
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

function getUrl(rt){
    var url="";
    if(rt=="all"){
        url=urlprefix+"method=get_all_lines&citycode="+u_citycode+"&mapType=BAIDU&cn=gm&lastmodi=0";
    }else if(rt=="city"){
        url=urlprefix+"method=get_realtime_city&lastmodi=0&mapType=BAIDU&cn=gm";
    }
    return url;
}

function dtc(d){
    return d;
}
