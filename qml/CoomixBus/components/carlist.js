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

function getSeq(d){
    for(var j=0; j<temp_sl.length; j++){
        if(d==temp_sl[j].id){
            return j;
        }
    }
    return -1;
}
