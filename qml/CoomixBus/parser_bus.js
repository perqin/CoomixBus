var urlprefix = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?";
var u_citycode, u_sublineid, u_lastmodi, u_lat, u_lng;
var o_line;

/*sublineid=99566
citycode=860515
lastmodi=0
lat=4.9E-324
lng=4.9E-324*/

function parseJson(t,j){
    if(t=="line"){
        o_line=JSON.parse(j);
    }
}

//method=getnearcarinfov4&sublineid=99566&mapType=BAIDU&citycode=860515&cn=gm&posmaptype=BAIDU&lastmodi=0&lat=4.9E-324&lng=4.9E-324
function getUrl(rt){
    var url="";
    if(rt=="line"){
        url=urlprefix+"method=getnearcarinfov4&sublineid="+u_sublineid+"&mapType=BAIDU&citycode="+u_citycode+"&cn=gm&posmaptype=BAIDU&lastmodi="+u_lastmodi+"&lat="+u_lat+"&lng="+u_lng;
    }else if(rt=="bus"){
        //url=urlprefix+"method=get_realtime_city&lastmodi=0&mapType=BAIDU&cn=gm";
    }
    return url;
}
