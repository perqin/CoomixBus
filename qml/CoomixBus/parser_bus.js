var urlprefix = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?";
var u_citycode, u_sublineid, u_lastmodi, u_lat, u_lng, u_stationId;
var u_ids="";
var o_line, o_bus;
var d_direction=0;

/*sublineid=99566
citycode=860515
lastmodi=0
lat=4.9E-324
lng=4.9E-324*/

function getTimerP(k) {
    if(k == 0) {
        return -1;
    }
    if(k == 1) {
        return 1;
    }
    if(k == 2) {
        return 3;
    }
    if(k == 3) {
        return 6;
    }
    if(k == 4) {
        return 12;
    }
}

function setIds() {
    var n;
    if(o_bus.data.cars.length>4){
        n=4;
    }else{
        n=o_bus.data.cars.length;
    }

}

function parseJson(t,j){
    if(t=="line"){
        o_line=JSON.parse(j);
    }else if(t=="wait"){
        o_bus=JSON.parse(j);
    }
}

//method=getnearcarinfov4&sublineid=99566&mapType=BAIDU&citycode=860515&cn=gm&posmaptype=BAIDU&lastmodi=0&lat=4.9E-324&lng=4.9E-324
function getUrl(rt){
    var url="";
    if(rt=="line"){
        url=urlprefix+"method=getnearcarinfov4&sublineid="+u_sublineid+"&mapType=BAIDU&citycode="+u_citycode+"&cn=gm&posmaptype=BAIDU&lastmodi="+u_lastmodi+"&lat="+u_lat+"&lng="+u_lng;
    }else if(rt=="bus"){
        //url=urlprefix+"method=get_realtime_city&lastmodi=0&mapType=BAIDU&cn=gm";
    }else if(rt=="wait"){
        //method=getnearcarinfo&cn=gm&ids=&sublineid=99426&stationId=1907898&mapType=BAIDU&citycode=860515
        url=urlprefix+"method=getnearcarinfo&cn=gm&ids=&sublineid="+u_sublineid+"&stationId="+u_stationId+"&mapType=BAIDU&citycode="+u_citycode;
    }else if(rt=="station"){
        //method=getnearcarinfo&cn=gm&ids=&sublineid=99426&stationId=1907898&mapType=BAIDU&citycode=860515
        url=urlprefix+"method=getnearcarinfo&cn=gm&ids=&sublineid="+u_sublineid+"&stationId="+u_stationId+"&mapType=BAIDU&citycode="+u_citycode;
    }
    return url;
}

function getSeq(){
    for(var j=0; j<o_line.data.dir[d_direction].stations.length; j++){
        //console.log(o_line.data.dir[d_direction].stations[j].id);
        if(o_line.data.dir[d_direction].stations[j].id==o_line.data.station.id){
            console.log("Station Seq : ");
            console.log(j);
            return j;
        }
    }
}
