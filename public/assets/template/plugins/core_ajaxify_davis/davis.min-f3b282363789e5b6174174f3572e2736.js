/*!
 * Davis - http://davisjs.com - JavaScript Routing - 0.9.9
 * Copyright (C) 2011 Oliver Nightingale
 * MIT Licensed
 */
Davis=function(a){var b=new Davis.App;return a&&a.call(b),Davis.$(function(){b.start()}),b},window.jQuery?Davis.$=jQuery:Davis.$=null,Davis.supported=function(){return typeof window.history.pushState=="function"},Davis.noop=function(){},Davis.extend=function(a){a(Davis)},Davis.version="0.9.9",Davis.utils=function(){if(Array.prototype.every)var a=function(a,b){return a.every(b,arguments[2])};else var a=function(a,b){if(a===void 0||a===null)throw new TypeError;var c=Object(a),d=c.length>>>0;if(typeof b!="function")throw new TypeError;var e=arguments[2];for(var f=0;f<d;f++)if(f in c&&!b.call(e,c[f],f,c))return!1;return!0};if(Array.prototype.forEach)var b=function(a,b){return a.forEach(b,arguments[2])};else var b=function(a,b){if(a===void 0||a===null)throw new TypeError;var c=Object(a),d=c.length>>>0;if(typeof b!="function")throw new TypeError;var e=arguments[2];for(var f=0;f<d;f++)f in c&&b.call(e,c[f],f,c)};if(Array.prototype.filter)var c=function(a,b){return a.filter(b,arguments[2])};else var c=function(a,b){if(a===void 0||a===null)throw new TypeError;var c=Object(a),d=c.length>>>0;if(typeof b!="function")throw new TypeError;var e=[],f=arguments[2];for(var g=0;g<d;g++)if(g in c){var h=c[g];b.call(f,h,g,c)&&e.push(h)}return e};if(Array.prototype.map)var d=function(a,b){return a.map(b,arguments[2])};else var d=function(a,b){if(a===void 0||a===null)throw new TypeError;var c=Object(a),d=c.length>>>0;if(typeof b!="function")throw new TypeError;var e=new Array(d),f=arguments[2];for(var g=0;g<d;g++)g in c&&(e[g]=b.call(f,c[g],g,c));return e};var e=function(a,b){return Array.prototype.slice.call(a,b||0)};return{every:a,forEach:b,filter:c,toArray:e,map:d}}(),Davis.listener=function(){var a={A:function(a){return a.host!==window.location.host||a.protocol!==window.location.protocol},FORM:function(a){var b=document.createElement("a");return b.href=a.action,this.A(b)}},b=function(b){return a[b.nodeName.toUpperCase()]?a[b.nodeName.toUpperCase()](b):!0},c=function(a){return a.altKey||a.ctrlKey||a.metaKey||a.shiftKey},d=function(a){return function(d){if(c(d))return!0;if(b(this))return!0;var e=new Davis.Request(a.call(Davis.$(this)));return Davis.location.assign(e),d.stopPropagation(),d.preventDefault(),!1}},e=d(function(){var a=this;return{method:"get",fullPath:this.prop("href"),title:this.attr("title"),delegateToServer:function(){window.location=a.prop("href")}}}),f=d(function(){var a=this;return{method:this.attr("method"),fullPath:this.serialize()?[this.prop("action"),this.serialize()].join("?"):this.prop("action"),title:this.attr("title"),delegateToServer:function(){a.submit()}}});this.listen=function(){Davis.$(document).delegate(this.settings.formSelector,"submit",f),Davis.$(document).delegate(this.settings.linkSelector,"click",e)},this.unlisten=function(){Davis.$(document).undelegate(this.settings.linkSelector,"click",e),Davis.$(document).undelegate(this.settings.formSelector,"submit",f)}},Davis.event=function(){var a={};this.bind=function(b,c){return(a[b]=a[b]||[]).push(c),this},this.trigger=function(b){var c=Davis.utils.toArray(arguments,1),d=a[b];if(!d)return this;for(var e=0,f=d.length;e<f;++e)d[e].apply(this,c);return this}},Davis.logger=function(){function a(){return"["+Date()+"]"}function b(b){var c=Davis.utils.toArray(b);return c.unshift(a()),c.join(" ")}var c=function(a){return function(){window.console&&console[a](b(arguments))}},d=c("error"),e=c("info"),f=c("warn");this.logger={error:d,info:e,warn:f}},Davis.Route=function(){var a=/:([\w\d]+)/g,b="([^/]+)",c=/\*([\w\d]+)/g,d="(.*)",e=/[:|\*]([\w\d]+)/g,f=function(f,g,h){var i=function(){if(g instanceof RegExp)return g;var e=g.replace(a,b).replace(c,d);return g.lastIndex=0,new RegExp("^"+e+"$","gi")},j=function(){return f instanceof RegExp?f:new RegExp("^"+f+"$","i")},k=function(){var a=[],b;while(b=e.exec(g))a.push(b[1]);return a};this.paramNames=k(),this.path=i(),this.method=j(),typeof h=="function"?this.handlers=[h]:this.handlers=h};return f.prototype.match=function(a,b){return this.reset(),this.method.test(a)&&this.path.test(b)},f.prototype.reset=function(){this.method.lastIndex=0,this.path.lastIndex=0},f.prototype.run=function(a){this.reset();var b=this.path.exec(a.path);if(b){b.shift();for(var c=0;c<b.length;c++)a.params[this.paramNames[c]]=b[c]}var d=Davis.utils.map(this.handlers,function(a,b){return function(c){return a.call(c,c,d[b+1])}});return d[0](a)},f.prototype.toString=function(){return[this.method,this.path].join(" ")},f}(),Davis.router=function(){this.route=function(b,d){var e=function(d){var e=Davis.utils.toArray(arguments,1),f=c.join(""),g,h;return typeof d=="string"?g=f+d:g=d,h=new Davis.Route(b,g,e),a.push(h),h};return arguments.length==1?e:e.apply(this,Davis.utils.toArray(arguments,1))},this.get=this.route("get"),this.post=this.route("post"),this.put=this.route("put"),this.del=this.route("delete"),this.state=this.route("state"),this.scope=function(a,b){c.push(a);if(arguments.length==1)return;b.call(this,this),c.pop()},this.trans=function(a,b){if(b)var c=[a,decodeURIComponent(Davis.$.param(b))].join("?");else var c=a;var d=new Davis.Request({method:"state",fullPath:c,title:""});Davis.location.assign(d)},this.filter=function(a){return function(){var d=/.+/;if(arguments.length==1)var e=/.+/,f=arguments[0];else if(arguments.length==2)var e=c.join("")+arguments[0],f=arguments[1];var g=new Davis.Route(d,e,f);return b[a].push(g),g}},this.lookupFilter=function(a){return function(c,d){return Davis.utils.filter(b[a],function(a){return a.match(c,d)})}},this.before=this.filter("before"),this.after=this.filter("after"),this.lookupBeforeFilter=this.lookupFilter("before"),this.lookupAfterFilter=this.lookupFilter("after");var a=[],b={before:[],after:[]},c=[];this.lookupRoute=function(b,c){return Davis.utils.filter(a,function(a){return a.match(b,c)})[0]}},Davis.history=function(){function c(b){a.push(b)}function d(a){window.addEventListener("popstate",a,!0)}function e(a){return function(c){c.state&&c.state._davis?a(new Davis.Request(c.state._davis)):b&&a(Davis.Request.forPageLoad()),b=!0}}function f(a){return{_davis:a}}function g(a){c(a),d(e(a))}function h(c){return function(d,e){b=!0,history[c](f(d.toJSON()),d.title,d.location());if(e&&e.silent)return;Davis.utils.forEach(a,function(a){a(d)})}}function k(){return window.location.pathname+(window.location.search?window.location.search:"")}var a=[],b=!1,i=h("pushState"),j=h("replaceState");return{onChange:g,current:k,assign:i,replace:j}}(),Davis.location=function(){function b(b){a=b}function c(){return a.current()}function d(b){return function(c,d){typeof c=="string"&&(c=new Davis.Request(c)),a[b](c,d)}}function g(b){a.onChange(b)}var a=Davis.history,e=d("assign"),f=d("replace");return{setLocationDelegate:b,current:c,assign:e,replace:f,onChange:g}}(),Davis.Request=function(){var a=function(b,c){typeof b=="object"&&(c=b,b=c.fullPath,delete c.fullPath);var d=Davis.$.extend({},{title:"",fullPath:b,method:"get",timestamp:+(new Date)},c);d.fullPath=d.fullPath.replace(/\+/g,"%20");var e=this;this.raw=d,this.params={},this.title=d.title,this.queryString=d.fullPath.split("?")[1],this.timestamp=d.timestamp,this._staleCallback=function(){},this.queryString&&Davis.utils.forEach(this.queryString.split("&"),function(a){var b=decodeURIComponent(a.split("=")[0]),c=a.split("=")[1],d=/^(\w+)\[(\w+)?\](\[\])?/,f;if(f=d.exec(b)){var g=f[1],b=f[2],h=!!f[3],i=e.params[g]||{};h?(i[b]=i[b]||[],i[b].push(decodeURIComponent(c)),e.params[g]=i):!b&&!h?(i=e.params[g]||[],i.push(decodeURIComponent(c)),e.params[g]=i):(i[b]=decodeURIComponent(c),e.params[g]=i)}else e.params[b]=decodeURIComponent(c)}),d.fullPath=d.fullPath.replace(/^https?:\/\/.+?\//,"/"),this.method=(this.params._method||d.method).toLowerCase(),this.path=d.fullPath.replace(/\?(.|[\r\n])+$/,"").replace(/^https?:\/\/[^\/]+/,""),this.fullPath=d.fullPath,this.delegateToServer=d.delegateToServer||Davis.noop,this.isForPageLoad=d.forPageLoad||!1,a.prev&&a.prev.makeStale(this),a.prev=this};return a.prototype.redirect=function(b,c){Davis.location.replace(new a({method:"get",fullPath:b,title:this.title}),c)},a.prototype.whenStale=function(a){this._staleCallback=a},a.prototype.makeStale=function(a){this._staleCallback.call(a,a)},a.prototype.location=function(){return this.method==="get"?decodeURI(this.fullPath):""},a.prototype.toString=function(){return[this.method.toUpperCase(),this.path].join(" ")},a.prototype.toJSON=function(){return{title:this.raw.title,fullPath:this.raw.fullPath,method:this.raw.method,timestamp:this.raw.timestamp}},a.forPageLoad=function(){return new this({method:"get",fullPath:Davis.location.current(),title:document.title,forPageLoad:!0})},a.prev=null,a}(),Davis.App=function(){function a(){this.running=!1,this.boundToInternalEvents=!1,this.use(Davis.listener),this.use(Davis.event),this.use(Davis.router),this.use(Davis.logger)}return a.prototype.configure=function(a){a.call(this.settings,this.settings)},a.prototype.use=function(a){a.apply(this,Davis.utils.toArray(arguments,1))},a.prototype.helpers=function(a){for(property in a)a.hasOwnProperty(property)&&(Davis.Request.prototype[property]=a[property])},a.prototype.settings={linkSelector:"a",formSelector:"form",throwErrors:!0,handleRouteNotFound:!1,generateRequestOnPageLoad:!1},a.prototype.start=function(){var a=this;if(this.running)return;if(!Davis.supported()){this.trigger("unsupported");return}var b=function(a){return function(b){var c=b.run(a,a);return typeof c=="undefined"||c}},c=function(c){return Davis.utils.every(a.lookupBeforeFilter(c.method,c.path),b(c))},d=function(d){if(c(d)){a.trigger("lookupRoute",d);var e=a.lookupRoute(d.method,d.path);if(e){a.trigger("runRoute",d,e);try{e.run(d),a.trigger("routeComplete",d,e)}catch(f){a.trigger("routeError",d,e,f)}Davis.utils.every(a.lookupAfterFilter(d.method,d.path),b(d))}else a.trigger("routeNotFound",d)}else a.trigger("requestHalted",d)},e=function(){a.bind("runRoute",function(b){a.logger.info("runRoute: "+b.toString())}).bind("routeNotFound",function(b){!a.settings.handleRouteNotFound&&!b.isForPageLoad&&(a.stop(),b.delegateToServer()),a.logger.warn("routeNotFound: "+b.toString())}).bind("start",function(){a.logger.info("application started")}).bind("stop",function(){a.logger.info("application stopped")}).bind("routeError",function(b,c,d){if(a.settings.throwErrors)throw d;a.logger.error(d.message,d.stack)}),Davis.location.onChange(function(a){d(a)}),a.boundToInternalEvents=!0};this.boundToInternalEvents||e(),this.listen(),this.trigger("start"),this.running=!0,this.settings.generateRequestOnPageLoad&&d(Davis.Request.forPageLoad())},a.prototype.stop=function(){this.unlisten(),this.trigger("stop"),this.running=!1},a}();
