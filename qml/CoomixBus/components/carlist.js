var temp_sl;

function tT(x) {
    return x;
}

function getM(t) {
    return (t-(t % 60))/60;
}

function getS(t) {
    return t % 60;
}

function getZ(i, j) {
    var m;
    for(var k=0; k<temp_sl.length; k++) {
        if(temp_sl[k].id == i){
            m = temp_sl[k].seq;
        }
        if(temp_sl[k].id == j){
            return (temp_sl[k].seq - m);
        }
    }
}
