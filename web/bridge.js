'use strict';

async function nip07getPublicKey(){
    if(window.nostr == undefined){
        return "";
    }
    if(window.nostr.getPublicKey == undefined){
        return "";
    }
    var result = await window.nostr.getPublicKey();
    if(result["error"] != undefined){
        return "";
    }

    return result;
}

async function nip07signEvent(event) {
    if(window.nostr == undefined){
        return "";
    }
    if(window.nostr.signEvent == undefined){
        return "";
    }
    var result = await window.nostr.signEvent(JSON.parse(event));
    if(result["error"] != undefined){
        return "";
    }
    return JSON.stringify(result);
}