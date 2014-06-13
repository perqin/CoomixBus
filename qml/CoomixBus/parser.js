var historyList, allList, filterList;
var cityList = [{"name":"深圳","code":"860515"},
                {"name":"惠州","code":"860506"},
                {"name":"西安","code":"862307"},
                {"name":"北京","code":"860201"}];
var cityNameList = new Array();
var urlprefix = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?";
var u_citycode;
var o_alllines;

function parseJson(t,j){
    if(t=="all"){
        o_alllines=JSON.parse(j);
    }
}

function getCityName(code){
    for(var i=0;i<cityList.length;i++){
        if(cityList[i].code==code){ return cityList[i].name; }
    }
}

function initNameList(){
    for(var i=0;i<cityList.length;i++){ cityNameList[i] = cityList[i].name; }
}

function getUrl(rt){
    var url="";
    //method=get_all_lines&citycode=860515&mapType=BAIDU&cn=gm&lastmodi=1402038259
    if(rt=="all"){
        url=urlprefix+"method=get_all_lines&citycode="+u_citycode+"&mapType=BAIDU&cn=gm&lastmodi=0";
    }
    return url;
}
