/*! jQuery.LazyJaxDavis (https://github.com/Takazudo/jQuery.LazyJaxDavis)
 * lastupdate: 2013-07-13
 * version: 0.2.2
 * author: "Takazudo" Takeshi Takatsudo
 * License: MIT */

(function(){var t=[].slice,e={}.hasOwnProperty,r=function(t,r){function n(){this.constructor=t}for(var i in r)e.call(r,i)&&(t[i]=r[i]);return n.prototype=r.prototype,t.prototype=new n,t.__super__=r.prototype,t};(function(e,n,i){var o,a,s,h,u;return h={},o=e(i),u=h.wait=function(t){return e.Deferred(function(e){return setTimeout(function(){return e.resolve()},t)})},e.support.pushstate=e.isFunction(n.history.pushState),h.isToId=function(t){return"#"===t.charAt(0)?!0:!1},h.trimAnchor=function(t){return t.replace(/#.*/,"")},h.trimGetVals=function(t){return t.replace(/\?.*/,"")},h.tryParseAnotherPageAnchor=function(t){var e,r;return h.isToId(t)?!1:-1===t.indexOf("#")?!1:(e=t.match(/^([^#]+)#(.+)/),r={path:e[1]},e[2]&&(r.hash="#"+e[2]),r)},h.filterStr=function(t,r,n){var i;return n?(i=[],t.replace(r,function(t,e){return i.push(e)}),i):(i=t.match(r),i&&i[1]?e.trim(i[1]):null)},h.logger=n.Davis?(new Davis.logger).logger:null,h.info=s=function(t){return h.logger?h.logger.info(t):void 0},h.error=a=function(t){return h.logger?h.logger.error(t):void 0},h.fetchPage=function(){var t;return t=null,function(r,n){var i;return i=e.Deferred(function(i){var o;return null!=(null!=t?t.abort:void 0)&&t.abort(),o={url:r},n=e.extend(o,n),t=e.ajax(n),t.then(function(e){return t=null,i.resolve(e)},function(t,e){var r;return r="abort"===e,i.reject(r)})}).promise(),i.abort=function(){return null!=t?"function"==typeof t.abort?t.abort():void 0:void 0},i}}(),h.Event=function(){function e(){this._callbacks={}}return e.prototype.bind=function(t,e){var r,n,i,o,a;for(r=t.split(" "),o=0,a=r.length;a>o;o++)n=r[o],(i=this._callbacks)[n]||(i[n]=[]),this._callbacks[n].push(e);return this},e.prototype.one=function(t,e){return this.bind(t,function(){return this.unbind(t,arguments.callee),e.apply(this,arguments)})},e.prototype.trigger=function(){var e,r,n,i,o,a,s;if(e=arguments.length>=1?t.call(arguments,0):[],n=e.shift(),i=null!=(s=this._callbacks)?s[n]:void 0){for(o=0,a=i.length;a>o&&(r=i[o],r.apply(this,e)!==!1);o++);return this}},e.prototype.unbind=function(t,e){var r,n,i,o,a,s;if(!t)return this._callbacks={},this;if(i=null!=(s=this._callbacks)?s[t]:void 0,!i)return this;if(!e)return delete this._callbacks[t],this;for(n=o=0,a=i.length;a>o;n=++o)if(r=i[n],r===e){i=i.slice(),i.splice(n,1),this._callbacks[t]=i;break}return this},e}(),h.HistoryLogger=function(){function t(){this._items=[],this._items.push(h.trimAnchor(location.pathname))}return t.prototype.push=function(t){return this._items.push(t),this},t.prototype.last=function(){var t;return t=this._items.length,t?this._items[t-1]:null},t.prototype.isToSamePageRequst=function(t){var e;return t=h.trimAnchor(t),e=h.trimAnchor(this.last()),e?t===e?!0:!1:!1},t.prototype.size=function(){return this._items.length},t}(),h.Page=function(t){function s(t,r,n,i,o,a){var h,p,l,c=this;this.request=t,this.routed=n,this.router=i,this.hash=a,s.__super__.constructor.apply(this,arguments),this.config=e.extend({},this.config,r),this.options=e.extend(!0,{},this.options,o),this.path="string"===e.type(this.config.path)?this.config.path:this.request.path,e.each(u,function(t,r){return e.each(c.config,function(t,e){return r!==t?!0:c.bind(r,e)})}),h=(null!=(p=this.config)?p.anchorhandler:void 0)||(null!=(l=this.options)?l.anchorhandler:void 0),h&&(this._anchorhandler=h),this.bind("pageready",function(){return c.hash?c._anchorhandler.call(c,c.hash):void 0})}var u;return r(s,t),u=["fetchstart","fetchsuccess","fetchabort","fetchfail","pageready","anchorhandler"],s.prototype.options={ajxoptions:{dataType:"text",cache:!0},expr:null,updatetitle:!0,title:null},s.prototype.router=null,s.prototype.config=null,s.prototype._text=null,s.prototype._anchorhandler=function(t){var e;return t?(e=o.find(t).offset().top,n.scrollTo(0,e),this):this},s.prototype.fetch=function(){var t,r,n,i,o,a,s=this;return t=null,n=this.request.path,r=(null!=(i=this.options)?i.ajaxoptions:void 0)||{},(null!=(o=this.config)?o.method:void 0)&&(r.type=this.config.method),(null!=(a=this.request)?a.params:void 0)&&(r.data=e.extend(!0,{},r.data,this.request.params)),this._fetchDefer=e.Deferred(function(e){return t=h.fetchPage(n,r),t.then(function(t){return s._text=t,s.updatetitle(),e.resolve()},function(t){return e.reject({aborted:t})}).always(function(){return s._fetchDefer=null})}),this._fetchDefer.abort=function(){return t.abort()},this._fetchDefer},s.prototype.abort=function(){var t;return null!=(t=this._fetchDefer)&&t.abort(),this},s.prototype.rip=function(t,e){var r,n,i,o;return this._text?t?(r=null!=(i=this.options)?null!=(o=i.expr)?o[t]:void 0:void 0)?(n=h.filterStr(this._text,r,e),n||a("ripper could not find the text for key: "+t),n):null:this._text:null},s.prototype.ripAll=function(t){return this.rip(t,!0)},s.prototype.updatetitle=function(){var t;return this.options.updatetitle?(t=null,!t&&this._text&&(t=this.rip("title")),t?(i.title=t,this):this):this},s}(h.Event),h.Router=function(n){function i(t){i.__super__.constructor.apply(this,arguments),this.history=new h.HistoryLogger,t.call(this,this),this.options.davis&&this._setupDavis(),this.firePageready(!this.options.firereadyonstart),this.fireTransPageready()}return r(i,n),i.prototype.options={ajaxoptions:{dataType:"text",cache:!0,type:"GET"},expr:{title:/<title[^>]*>([^<]*)<\/title>/,content:/<!-- LazyJaxDavis start -->([\s\S]*)<!-- LazyJaxDavis end -->/},davis:{linkSelector:"a:not([href^=#]):not(.apply-nolazy)",formSelector:"form:not(.apply-nolazy)",throwErrors:!1,handleRouteNotFound:!0},minwaittime:0,updatetitle:!0,firereadyonstart:!0,ignoregetvals:!1},i.prototype._createPage=function(t,e,r,n){var i,o;return i={expr:this.options.expr,updatetitle:this.options.updatetitle},this.options.anchorhandler&&(i.anchorhandler=this.options.anchorhandler),(null!=e?e.ajaxoptions:void 0)?i.ajaxoptions=e.ajaxoptions:this.options.ajaxoptions&&(i.ajaxoptions=this.options.ajaxoptions),!n&&(null!=t?t.path:void 0)&&(o=h.tryParseAnotherPageAnchor(t.path),n=o.hash||null),new h.Page(t,e,r,this,i,n)},i.prototype._setupDavis=function(){var t,r,n;if(e.support.pushstate)return r=this,t=function(t){return t.bind("pageready",function(){return r._findWhosePathMatches("page",t.path),r.trigger("everypageready"),r.fireTransPageready()}),r.history.push(t.path),r.fetch(t)},this.davis=new Davis(function(){var n;return n=this,r.pages&&e.each(r.pages,function(i,o){var a;if("regexp"!==e.type(o.path))return a=(o.method||"get").toLowerCase(),n[a](o.path,function(e){var n;if(!r.history.isToSamePageRequst(e.path))return n=r._createPage(e,o,!0),t(n)}),!0}),r.options.davis.handleRouteNotFound&&n.bind("routeNotFound",function(e){var n,i,o,a,s,u;return h.isToId(e.path)?(r.trigger("toid",e.path),void 0):(s=h.tryParseAnotherPageAnchor(e.path),i=s.hash||null,a=s.path||e.path,r.history.isToSamePageRequst(a)?void 0:(n=r._findWhosePathMatches("page",a)||null,u=n?!0:!1,o=r._createPage(e,n,u,i),t(o)))}),n.configure(function(t){return e.each(r.options.davis,function(e,r){return t[e]=r,!0})})}),null!=(n=r.davisInitializer)&&n.call(davis),this._tweakDavis(),this},i.prototype._tweakDavis=function(){var e,r=this;return e=this.davis.logger.warn,s=this.davis.logger.info,this.davis.logger.warn=function(){var n;return n=arguments.length>=1?t.call(arguments,0):[],-1!==n[0].indexOf("routeNotFound")?(n[0]=n[0].replace(/routeNotFound/,"unRouted"),s.apply(r.davis.logger,n)):e.apply(r.davis.logger,n)},this},i.prototype._findWhosePathMatches=function(t,r,n){var i,o,s,u=this;if("page"===t){if(!this.pages||!this.pages.length)return null;i=this.pages}else if("transRoutes"===t){if(!this.transRoutes||!this.transRoutes.length)return null;i=this.transRoutes,n=!0}return o=[],s=h.trimGetVals(r),e.each(i,function(t,i){var a;if(a=u.options.ignoregetvals||i.ignoregetvals?s:r,"regexp"===e.type(i.path)){if(!i.path.test(a))return!0;if(o.push(i),n)return!0}return i.path===a&&(o.push(i),n)?!0:!0}),!n&&o.length>1?(a("2 or more expr was matched about: "+r),e.each(o,function(t,e){return a("dumps detected page configs - path:"+e.path)}),!1):n?o:o[0]||null},i.prototype.fetch=function(t){var r=this;return e.Deferred(function(n){return t.trigger("fetchstart",t),r.trigger("everyfetchstart",t),e.when(t.fetch(),u(r.options.minwaittime)).then(function(){return t.trigger("fetchsuccess",t),r.trigger("everyfetchsuccess",t),n.resolve()},function(e){return e.aborted?(t.trigger("fetchabort",t),r.trigger("everyfetchabort",t)):(t.trigger("fetchfil",t),r.trigger("everyfetchfail",t))})}).promise()},i.prototype.stop=function(){var t;return null!=(t=this.davis)&&t.stop(),this},i.prototype.navigate=function(t,e){var r;return this.davis?(r=new Davis.Request({method:e||"get",fullPath:t,title:""}),Davis.location.assign(r)):location.href=t,this},i.prototype.firePageready=function(t){var e,r;return(null!=(r=this.pages)?r.length:void 0)&&(e=this._findWhosePathMatches("page",location.pathname),e&&"function"==typeof e.pageready&&e.pageready()),t?this:(this.trigger("everypageready"),this)},i.prototype.fireTransPageready=function(){var t,r;if(null!=(r=this.transRoutes)?r.length:void 0){if(t=this._findWhosePathMatches("transRoutes",location.pathname),!t.length)return this;e.each(t,function(t,e){return"function"==typeof e.pageready?e.pageready():void 0})}return this},i.prototype.route=function(t){return this.pages=t,this},i.prototype.routeTransparents=function(t){return this.transRoutes=t,this},i.prototype.routeDavis=function(t){return this.davisInitializer=t,this},i.prototype.option=function(t){return t?this.options=e.extend(!0,{},this.options,t):this.options},i}(h.Event),e.LazyJaxDavisNs=h,e.LazyJaxDavis=h.Router})(jQuery,this,this.document)}).call(this);
