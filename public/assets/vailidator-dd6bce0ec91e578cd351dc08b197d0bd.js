$.validator.addMethod("url_amazon", function (value, element) {
    //return this.optional(element) || /^\s*(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*$/.test(value);
    var check = false;
    if((/^https:\/\/www.amazon.com/i).test(value) || (/^https:\/\/amazon.com/i).test(value) || (/^http:\/\/www.amazon.com/i).test(value) || (/^http:\/\/www.amazon.com/i).test(value)){
        if ((/tag=cu0f0-20&/).test(value) || (/tag=cu0f0-20$/).test(value)){
            check=true;
        }
    }

    return check;
}, "Amazon code sai ");