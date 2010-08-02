/* Copyright (c) 2008 Gilberto Saraiva (saraivagilberto@gmail.com || http://gsaraiva.projects.pro.br)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * Version: 2008.0.1.1 -
 * Under development and testing
 *
 * Requires: jQuery 1.2+
 *
 * Support/Site: http://gsaraiva.projects.pro.br/openprj/?page=jquerynamespace
 *
 * 2009/01/30 - Fixes by Marc van Neerven (marc@smartsite.nl)
 *  - Scoping bug fixed, causing methods not having wrong 'this' scope and missing chaining capabilities
 *  - Custom Alias trick not used (jQuery instead of $ passed to function)
 *  - Usage of many entry-level jQuery properties for internal housekeeping, replaced by single object: __ns
 */

(function( $ ){
  $.fn.extend({ __ns: { cur: null, init: $.fn.init } } );

  $.fn.extend({
  	init: function( selector, context ) {
      $.fn.__ns.cur = new $.fn.__ns.init(selector, context);
      return $.fn.__ns.cur;
  	}
  });

  $.extend({
  	__ns: {
	    obj: {},
	    extend: function(ns){
	      if(eval(ns) != undefined){ $.extend(eval(ns), {}); }else{ eval(ns + " = {};"); }
	    }
	  },
    namespace: function(namespaces, objects){
      if(typeof objects == "function"){
        if(namespaces.match(".")){
          nss = namespaces.split(".");
          snss = "";
          for(var i = 0; i < nss.length; i++){
            snss += "['" + nss[i] + "']";
            $.__ns.extend("$.__ns.obj" + snss);
            $.__ns.extend("$.fn" + snss);
          }
          eval("$.__ns.obj" + snss + " = objects;");
          eval("$.fn" + snss + " = " +
            "function(){ return eval(\"$.__ns.obj" + snss + ".apply($.fn.__ns.cur, arguments)\"); }");
        }else{
          $.extend({
            namespaces: function(){return objects($.fn.__ns.cur);}
          });
        }
      }else{
        for(var space in objects){
          $.namespace(namespaces + "." + space, objects[space]);
        };
      }
    }
  });
})( jQuery );