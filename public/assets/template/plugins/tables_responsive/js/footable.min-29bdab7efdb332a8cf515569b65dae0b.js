/*!
 * FooTable - Awesome Responsive Tables
 * Version : 2.0.1
 * http://fooplugins.com/plugins/footable-jquery/
 *
 * Requires jQuery - http://jquery.com/
 *
 * Copyright 2013 Steven Usher & Brad Vincent
 * Released under the MIT license
 * You are free to use FooTable in commercial projects as long as this copyright header is left intact.
 *
 * Date: 31 Aug 2013
 */

(function(e,t){function a(){var e=this;e.id=null,e.busy=!1,e.start=function(t,a){e.busy||(e.stop(),e.id=setTimeout(function(){t(),e.id=null,e.busy=!1},a),e.busy=!0)},e.stop=function(){null!==e.id&&(clearTimeout(e.id),e.id=null,e.busy=!1)}}function o(o,i,n){var r=this;r.id=n,r.table=o,r.options=i,r.breakpoints=[],r.breakpointNames="",r.columns={},r.plugins=t.footable.plugins.load(r);var l=r.options,d=l.classes,s=l.events,u=l.triggers,f=0;return r.timers={resize:new a,register:function(e){return r.timers[e]=new a,r.timers[e]}},r.init=function(){var a=e(t),o=e(r.table);if(t.footable.plugins.init(r),o.hasClass(d.loaded))return r.raise(s.alreadyInitialized),undefined;r.raise(s.initializing),o.addClass(d.loading),o.find(l.columnDataSelector).each(function(){var e=r.getColumnData(this);r.columns[e.index]=e});for(var i in l.breakpoints)r.breakpoints.push({name:i,width:l.breakpoints[i]}),r.breakpointNames+=i+" ";r.breakpoints.sort(function(e,t){return e.width-t.width}),o.bind(u.initialize,function(){o.removeData("footable_info"),o.data("breakpoint",""),o.trigger(u.resize),o.removeClass(d.loading),o.addClass(d.loaded).addClass(d.main),r.raise(s.initialized)}).bind(u.redraw,function(){r.redraw()}).bind(u.resize,function(){r.resize()}).bind(u.expandFirstRow,function(){o.find(l.toggleSelector).first().not("."+d.detailShow).trigger(u.toggleRow)}),o.trigger(u.initialize),a.bind("resize.footable",function(){r.timers.resize.stop(),r.timers.resize.start(function(){r.raise(u.resize)},l.delay)})},r.addRowToggle=function(){if(l.addRowToggle){var t=e(r.table),a=!1;t.find("span."+d.toggle).remove();for(var o in r.columns){var i=r.columns[o];if(i.toggle){a=!0;var n="> tbody > tr:not(."+d.detail+",."+d.disabled+") > td:nth-child("+(parseInt(i.index,10)+1)+")";return t.find(n).not("."+d.detailCell).prepend(e("<span />").addClass(d.toggle)),undefined}}a||t.find("> tbody > tr:not(."+d.detail+",."+d.disabled+") > td:first-child").not("."+d.detailCell).prepend(e("<span />").addClass(d.toggle))}},r.setColumnClasses=function(){$table=e(r.table);for(var t in r.columns){var a=r.columns[t];if(null!==a.className){var o="",i=!0;e.each(a.matches,function(e,t){i||(o+=", "),o+="> tbody > tr:not(."+d.detail+") > td:nth-child("+(parseInt(t,10)+1)+")",i=!1}),$table.find(o).not("."+d.detailCell).addClass(a.className)}}},r.bindToggleSelectors=function(){var t=e(r.table);r.hasAnyBreakpointColumn()&&(t.find(l.toggleSelector).unbind(u.toggleRow).bind(u.toggleRow,function(){var t=e(this).is("tr")?e(this):e(this).parents("tr:first");r.toggleDetail(t.get(0))}),t.find(l.toggleSelector).unbind("click.footable").bind("click.footable",function(a){t.is(".breakpoint")&&e(a.target).is("td,."+d.toggle)&&e(this).trigger(u.toggleRow)}))},r.parse=function(e,t){var a=l.parsers[t.type]||l.parsers.alpha;return a(e)},r.getColumnData=function(t){var a=e(t),o=a.data("hide"),i=a.index();o=o||"",o=jQuery.map(o.split(","),function(e){return jQuery.trim(e)});var n={index:i,hide:{},type:a.data("type")||"alpha",name:a.data("name")||e.trim(a.text()),ignore:a.data("ignore")||!1,toggle:a.data("toggle")||!1,className:a.data("class")||null,matches:[],names:{},group:a.data("group")||null,groupName:null};if(null!==n.group){var d=e(r.table).find('> thead > tr.footable-group-row > th[data-group="'+n.group+'"], > thead > tr.footable-group-row > td[data-group="'+n.group+'"]').first();n.groupName=r.parse(d,{type:"alpha"})}var u=parseInt(a.prev().attr("colspan")||0,10);f+=u>1?u-1:0;var p=parseInt(a.attr("colspan")||0,10),c=n.index+f;if(p>1){var g=a.data("names");g=g||"",g=g.split(",");for(var h=0;p>h;h++)n.matches.push(h+c),g.length>h&&(n.names[h+c]=g[h])}else n.matches.push(c);n.hide["default"]="all"===a.data("hide")||e.inArray("default",o)>=0;var b=!1;for(var m in l.breakpoints)n.hide[m]="all"===a.data("hide")||e.inArray(m,o)>=0,b=b||n.hide[m];n.hasBreakpoint=b;var v=r.raise(s.columnData,{column:{data:n,th:t}});return v.column.data},r.getViewportWidth=function(){return window.innerWidth||(document.body?document.body.offsetWidth:0)},r.calculateWidth=function(e,t){return jQuery.isFunction(l.calculateWidthOverride)?l.calculateWidthOverride(e,t):(t.viewportWidth<t.width&&(t.width=t.viewportWidth),t.parentWidth<t.width&&(t.width=t.parentWidth),t)},r.hasBreakpointColumn=function(e){for(var t in r.columns)if(r.columns[t].hide[e]){if(r.columns[t].ignore)continue;return!0}return!1},r.hasAnyBreakpointColumn=function(){for(var e in r.columns)if(r.columns[e].hasBreakpoint)return!0;return!1},r.resize=function(){var t=e(r.table);if(t.is(":visible")&&r.hasAnyBreakpointColumn()){var a={width:t.width(),viewportWidth:r.getViewportWidth(),parentWidth:t.parent().width()};a=r.calculateWidth(t,a);var o=t.data("footable_info");if(t.data("footable_info",a),r.raise(s.resizing,{old:o,info:a}),!o||o&&o.width&&o.width!==a.width){for(var i,n=null,l=0;r.breakpoints.length>l;l++)if(i=r.breakpoints[l],i&&i.width&&a.width<=i.width){n=i;break}var d=null===n?"default":n.name,f=r.hasBreakpointColumn(d),p=t.data("breakpoint");t.data("breakpoint",d).removeClass("default breakpoint").removeClass(r.breakpointNames).addClass(d+(f?" breakpoint":"")),d!==p&&(t.trigger(u.redraw),r.raise(s.breakpoint,{breakpoint:d,info:a}))}r.raise(s.resized,{old:o,info:a})}},r.redraw=function(){r.addRowToggle(),r.bindToggleSelectors(),r.setColumnClasses();var t=e(r.table),a=t.data("breakpoint"),o=r.hasBreakpointColumn(a);t.find("> tbody > tr:not(."+d.detail+")").data("detail_created",!1).end().find("> thead > tr:last-child > th").each(function(){var o=r.columns[e(this).index()],i="",n=!0;e.each(o.matches,function(e,t){n||(i+=", ");var a=t+1;i+="> tbody > tr:not(."+d.detail+") > td:nth-child("+a+")",i+=", > tfoot > tr:not(."+d.detail+") > td:nth-child("+a+")",i+=", > colgroup > col:nth-child("+a+")",n=!1}),i+=', > thead > tr[data-group-row="true"] > th[data-group="'+o.group+'"]';var l=t.find(i).add(this);if(o.hide[a]===!1?l.show():l.hide(),1===t.find("> thead > tr.footable-group-row").length){var s=t.find('> thead > tr:last-child > th[data-group="'+o.group+'"]:visible, > thead > tr:last-child > th[data-group="'+o.group+'"]:visible'),u=t.find('> thead > tr.footable-group-row > th[data-group="'+o.group+'"], > thead > tr.footable-group-row > td[data-group="'+o.group+'"]'),f=0;e.each(s,function(){f+=parseInt(e(this).attr("colspan")||1,10)}),f>0?u.attr("colspan",f).show():u.hide()}}).end().find("> tbody > tr."+d.detailShow).each(function(){r.createOrUpdateDetailRow(this)}),t.find("> tbody > tr."+d.detailShow+":visible").each(function(){var t=e(this).next();t.hasClass(d.detail)&&(o?t.show():t.hide())}),t.find("> thead > tr > th.footable-last-column, > tbody > tr > td.footable-last-column").removeClass("footable-last-column"),t.find("> thead > tr > th.footable-first-column, > tbody > tr > td.footable-first-column").removeClass("footable-first-column"),t.find("> thead > tr, > tbody > tr").find("> th:visible:last, > td:visible:last").addClass("footable-last-column").end().find("> th:visible:first, > td:visible:first").addClass("footable-first-column"),r.raise(s.redrawn)},r.toggleDetail=function(t){var a=t.jquery?t:e(t),o=a.next();a.hasClass(d.detailShow)?(a.removeClass(d.detailShow),o.hasClass(d.detail)&&o.hide(),r.raise(s.rowCollapsed,{row:a[0]})):(r.createOrUpdateDetailRow(a[0]),a.addClass(d.detailShow),a.next().show(),r.raise(s.rowExpanded,{row:a[0]}))},r.removeRow=function(t){var a=t.jquery?t:e(t);a.hasClass(d.detail)&&(a=a.prev());var o=a.next();a.data("detail_created")===!0&&o.remove(),a.remove(),r.raise(s.rowRemoved)},r.appendRow=function(t){var a=t.jquery?t:e(t);e(r.table).find("tbody").append(a),r.redraw()},r.getColumnFromTdIndex=function(t){var a=null;for(var o in r.columns)if(e.inArray(t,r.columns[o].matches)>=0){a=r.columns[o];break}return a},r.createOrUpdateDetailRow=function(t){var a,o=e(t),i=o.next(),n=[];if(o.data("detail_created")===!0)return!0;if(o.is(":hidden"))return!1;if(r.raise(s.rowDetailUpdating,{row:o,detail:i}),o.find("> td:hidden").each(function(){var t=e(this).index(),a=r.getColumnFromTdIndex(t),o=a.name;return a.ignore===!0?!0:(t in a.names&&(o=a.names[t]),n.push({name:o,value:r.parse(this,a),display:e.trim(e(this).html()),group:a.group,groupName:a.groupName}),!0)}),0===n.length)return!1;var u=o.find("> td:visible").length,f=i.hasClass(d.detail);return f||(i=e('<tr class="'+d.detail+'"><td class="'+d.detailCell+'"><div class="'+d.detailInner+'"></div></td></tr>'),o.after(i)),i.find("> td:first").attr("colspan",u),a=i.find("."+d.detailInner).empty(),l.createDetail(a,n,l.createGroupedDetail,l.detailSeparator,d),o.data("detail_created",!0),r.raise(s.rowDetailUpdated,{row:o,detail:i}),!f},r.raise=function(t,a){r.options.debug===!0&&e.isFunction(r.options.log)&&r.options.log(t,"event"),a=a||{};var o={ft:r};e.extend(!0,o,a);var i=e.Event(t,o);return i.ft||e.extend(!0,i,o),e(r.table).trigger(i),i},r.init(),r}t.footable={options:{delay:100,breakpoints:{phone:480,tablet:1024},parsers:{alpha:function(t){return e(t).data("value")||e.trim(e(t).text())},numeric:function(t){var a=e(t).data("value")||e(t).text().replace(/[^0-9.\-]/g,"");return a=parseFloat(a),isNaN(a)&&(a=0),a}},addRowToggle:!0,calculateWidthOverride:null,toggleSelector:" > tbody > tr:not(.footable-row-detail)",columnDataSelector:"> thead > tr:last-child > th, > thead > tr:last-child > td",detailSeparator:":",createGroupedDetail:function(e){for(var t={_none:{name:null,data:[]}},a=0;e.length>a;a++){var o=e[a].group;null!==o?(o in t||(t[o]={name:e[a].groupName||e[a].group,data:[]}),t[o].data.push(e[a])):t._none.data.push(e[a])}return t},createDetail:function(e,t,a,o,i){var n=a(t);for(var r in n)if(0!==n[r].data.length){"_none"!==r&&e.append('<div class="'+i.detailInnerGroup+'">'+n[r].name+"</div>");for(var l=0;n[r].data.length>l;l++){var d=n[r].data[l].name?o:"";e.append('<div class="'+i.detailInnerRow+'"><div class="'+i.detailInnerName+'">'+n[r].data[l].name+d+'</div><div class="'+i.detailInnerValue+'">'+n[r].data[l].display+"</div></div>")}}},classes:{main:"footable",loading:"footable-loading",loaded:"footable-loaded",toggle:"footable-toggle",disabled:"footable-disabled",detail:"footable-row-detail",detailCell:"footable-row-detail-cell",detailInner:"footable-row-detail-inner",detailInnerRow:"footable-row-detail-row",detailInnerGroup:"footable-row-detail-group",detailInnerName:"footable-row-detail-name",detailInnerValue:"footable-row-detail-value",detailShow:"footable-detail-show"},triggers:{initialize:"footable_initialize",resize:"footable_resize",redraw:"footable_redraw",toggleRow:"footable_toggle_row",expandFirstRow:"footable_expand_first_row"},events:{alreadyInitialized:"footable_already_initialized",initializing:"footable_initializing",initialized:"footable_initialized",resizing:"footable_resizing",resized:"footable_resized",redrawn:"footable_redrawn",breakpoint:"footable_breakpoint",columnData:"footable_column_data",rowDetailUpdating:"footable_row_detail_updating",rowDetailUpdated:"footable_row_detail_updated",rowCollapsed:"footable_row_collapsed",rowExpanded:"footable_row_expanded",rowRemoved:"footable_row_removed"},debug:!1,log:null},version:{major:0,minor:5,toString:function(){return t.footable.version.major+"."+t.footable.version.minor},parse:function(e){return version=/(\d+)\.?(\d+)?\.?(\d+)?/.exec(e),{major:parseInt(version[1],10)||0,minor:parseInt(version[2],10)||0,patch:parseInt(version[3],10)||0}}},plugins:{_validate:function(a){if(!e.isFunction(a))return t.footable.options.debug===!0&&console.error('Validation failed, expected type "function", received type "{0}".',typeof a),!1;var o=new a;return"string"!=typeof o.name?(t.footable.options.debug===!0&&console.error('Validation failed, plugin does not implement a string property called "name".',o),!1):e.isFunction(o.init)?(t.footable.options.debug===!0&&console.log('Validation succeeded for plugin "'+o.name+'".',o),!0):(t.footable.options.debug===!0&&console.error('Validation failed, plugin "'+o.name+'" does not implement a function called "init".',o),!1)},registered:[],register:function(a,o){t.footable.plugins._validate(a)&&(t.footable.plugins.registered.push(a),"object"==typeof o&&e.extend(!0,t.footable.options,o))},load:function(e){var a,o,i=[];for(o=0;t.footable.plugins.registered.length>o;o++)try{a=t.footable.plugins.registered[o],i.push(new a(e))}catch(n){t.footable.options.debug===!0&&console.error(n)}return i},init:function(e){for(var a=0;e.plugins.length>a;a++)try{e.plugins[a].init(e)}catch(o){t.footable.options.debug===!0&&console.error(o)}}}};var i=0;e.fn.footable=function(a){a=a||{};var n=e.extend(!0,{},t.footable.options,a);return this.each(function(){i++;var t=new o(this,n,i);e(this).data("footable",t)})}})(jQuery,window);
