
$.validator.addMethod("custom_email", function (value, element) {
    //return this.optional(element) || /^\s*(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*$/.test(value);

    return this.optional(element) || /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i.test(value);
}, "Please enter a valid email address");

//$.validator.addMethod("custom_email1", function (value, element) {
//    var emailExpression = /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})*$/gi;
//    var emailRegex = new RegExp(emailExpression);
//    return this.optional(element) || emailRegex.test(value);
//}, "Please enter a valid email address");

$.validator.addMethod("username", function (value, element) {
    //var nameExpression = /^[a-z0-9\._-]$/i
    //var nameRegex = new RegExp(nameExpression);
    //alert(nameRegex.test(value) + ' ' + /[a-z0-9_-]/i.test(value) + ' ' + /^[a-z]/i.test(value) + ' ' + /[a-z0-9]$/i.test(value));
    var usernameExpression = /^[a-z]+[a-z0-9\._-]+[a-z0-9]$/i
    var usernameRegex = new RegExp(usernameExpression);
    return this.optional(element) || usernameRegex.test(value);
}, "Please enter a valid user name");

$.validator.addMethod("alphanumeric", function(value, element) {
    return this.optional(element) || /^\s*[^(~`!@#$%^&*()-+\\[\]\{\}=,?\/:;'"|><)]*\s*$/i.test(value);
}, "Letters, numbers, and underscores only please");

$.validator.addMethod("now_year", function (value, element) {
    now = new Date();
    year = now.getUTCFullYear();
    return year < value;
}, "Please enter a valid year");

$.validator.addMethod("less", function(value, element, param) {
    return this.optional(element) || value < $(param).val();
}, "less");

$.validator.addMethod("less_or_equals", function(value, element, param) {
    return this.optional(element) || value <= $(param).val();
}, "less_or_equals");

$.validator.addMethod("greater", function(value, element, param) {
    return this.optional(element) || value > $(param).val();
}, "greater");

$.validator.addMethod("greater_or_equals", function(value, element, param) {
    return this.optional(element) || value >= $(param).val();
}, "greater_or_equals");

$.validator.addMethod("accept_file_extension", function(value, element, param) {
    var splitedFileName = value.split('.');
    var fileExtension = splitedFileName[splitedFileName.length - 1];

    var acceptExtensions = param.split(',');
    return this.optional(element) || acceptExtensions.indexOf(fileExtension) >= 0
}, "This extension file is invalid.");

