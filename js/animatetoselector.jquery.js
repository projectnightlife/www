/*
 * animateToSelector jQuery plugin
 * Copyright (c) 2009 James Padolsey
 * j@qd9.co.uk | http://james.padolsey.com
 * Dual licensed under MIT and GPL.
 * Updated: 10/02/09
 * @author James Padolsey
 * @version 0.1.experimental
 */

(function($){
    
    // Color animations for jQuery, CopyRight (C) John Resig:
    (function(d){d.each(['backgroundColor','borderBottomColor','borderLeftColor','borderRightColor','borderTopColor','color','outlineColor'],function(b,c){d.fx.step[c]=function(a){if(a.state==0){a.start=f(a.elem,c);a.end=e(a.end)}a.elem.style[c]="rgb("+[Math.max(Math.min(parseInt((a.pos*(a.end[0]-a.start[0]))+a.start[0]),255),0),Math.max(Math.min(parseInt((a.pos*(a.end[1]-a.start[1]))+a.start[1]),255),0),Math.max(Math.min(parseInt((a.pos*(a.end[2]-a.start[2]))+a.start[2]),255),0)].join(",")+")"}});function e(a){var b;if(a&&a.constructor==Array&&a.length==3)return a;if(b=/rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(a))return[parseInt(b[1]),parseInt(b[2]),parseInt(b[3])];if(b=/rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(a))return[parseFloat(b[1])*2.55,parseFloat(b[2])*2.55,parseFloat(b[3])*2.55];if(b=/#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(a))return[parseInt(b[1],16),parseInt(b[2],16),parseInt(b[3],16)];if(b=/#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(a))return[parseInt(b[1]+b[1],16),parseInt(b[2]+b[2],16),parseInt(b[3]+b[3],16)];return g[d.trim(a).toLowerCase()]}function f(a,b){var c;do{c=d.curCSS(a,b);if(c!=''&&c!='transparent'||d.nodeName(a,"body"))break;b="backgroundColor"}while(a=a.parentNode);return e(c)};var g={aqua:[0,255,255],azure:[240,255,255],beige:[245,245,220],black:[0,0,0],blue:[0,0,255],brown:[165,42,42],cyan:[0,255,255],darkblue:[0,0,139],darkcyan:[0,139,139],darkgrey:[169,169,169],darkgreen:[0,100,0],darkkhaki:[189,183,107],darkmagenta:[139,0,139],darkolivegreen:[85,107,47],darkorange:[255,140,0],darkorchid:[153,50,204],darkred:[139,0,0],darksalmon:[233,150,122],darkviolet:[148,0,211],fuchsia:[255,0,255],gold:[255,215,0],green:[0,128,0],indigo:[75,0,130],khaki:[240,230,140],lightblue:[173,216,230],lightcyan:[224,255,255],lightgreen:[144,238,144],lightgrey:[211,211,211],lightpink:[255,182,193],lightyellow:[255,255,224],lime:[0,255,0],magenta:[255,0,255],maroon:[128,0,0],navy:[0,0,128],olive:[128,128,0],orange:[255,165,0],pink:[255,192,203],purple:[128,0,128],violet:[128,0,128],red:[255,0,0],silver:[192,192,192],white:[255,255,255],yellow:[255,255,0]}})(jQuery);
    // End;
    
    function getStyle(selector,property) {
        var regex = new RegExp(selector + '$','gi'),
            ret;
        if (document.all) {
            $.each(document.styleSheets, function(i, ss){
                var found = 0;
                $.each(ss.rules, function(i, rule){
                    if (rule.selectorText.match(regex)) {
                        ret = rule.style[property];
                        found = 1;
                        return false;
                    }
                });
                return !found;
            });
        } else {
            if (document.getElementById) {
                $.each(document.styleSheets, function(i, ss){
                    $.each(ss.cssRules, function(i, rule){
                        if (rule.selectorText.match(regex)) {
                            ret = rule.style[property];
                        }
                    });
                });
            }
        }
        
        return ret;
    }
    
    function camelCase(prop) {
        return prop.replace(/-([a-z])/gi, function(){
            // Replace -c with C:
            return arguments[1].toUpperCase();
        });
    }
    
    $.fn.animateToSelector = function(options) {
        
        var s = $.extend({
            
            selectors : [],
            properties: [],
            duration: 400,
            events: []
            
        }, options);
        
        (s.items ? $(s.items, this) : $(this)).each(function(i){
            
            var thisItem = this,
                aniObject = (function(){
                    var ret = [{length:0},{length:0}];
                    $.each(s.properties, function(i,prop){
                        prop = camelCase(prop);
                        var current = $(thisItem).css(prop), hovered = null;
                        $.each(s.selectors, function(i, selector){
                            hovered = hovered || getStyle(selector, prop);
                        });
                        if (current) { ret[0][prop] = current; ret[0].length++; }
                        if (hovered) { ret[1][prop] = hovered; ret[1].length++; }
                    });
                    
                    return ret;
                })();
                
            if (!aniObject[0].length || aniObject[0].length !== aniObject[1].length) {
                return false;
            } else {
                delete aniObject[0].length;
                delete aniObject[1].length;
            }
            
            if (s.selectors.join(',').match(/:[^,]+(,|$)/)) {
                $(thisItem).css(aniObject[0]);
            }
            
            function run(elem,i) {
                $(elem).stop().animate(aniObject[i], s.duration);
            }
            
            if (!s.events || !s.events.length) {
                run(thisItem, 1);
                return true;
            }
            
            s.events[0] && $(thisItem).bind(s.events[0], function(){
                run(this, 1);
            });
            
            s.events[1] && $(thisItem).bind(s.events[1], function(){
                run(this, 0);
            });
            
        });
        
        return this;
    
    };
    
})(jQuery);