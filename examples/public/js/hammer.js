//var descendant = function(parent, child) {
//  var F = function() {};
//  F.prototype = parent.prototype;
//  child.prototype = new F();
//  child._superClass = parent.prototype;
//  child.prototype.constructor = child;
//};

(function($) {

  //   jQuery.fn.myPlugin = function(settings) {
  //     var config = {'foo': 'bar'};
  //     if (settings) $.extend(config, settings);
  //
  //     this.each(function(i, elem) {
  //       // element-specific code here
  //     });
  //
  //     return this;
  //   };

  var logger = {
    error:  function(message) {
      console.error(message);
    //    if(hammer.sendLogBack == true) new Hammer.Log('error', message).send();
    },

    warn:  function(message) {
      console.warn(message);
    //    if(hammer.sendLogBack == true) new Hammer.Log('warn', message).send();
    },

    info:  function(message) {
      console.info(message);
    //    if(hammer.sendLogBack == true) new Hammer.Log('info', message).send();
    },

    debug:  function(message) {
      console.debug(message);
    //    if(hammer.sendLogBack == true) new Hammer.Log('debug', message).send();
    }
  };

  var dump = function(obj) {
    logger.debug(obj);
    return obj
  }

  var reciever = {
    execute: function(json) {
      if (json.html) this.replaceBody(json.html);
      if (json.js) this.evalJs(json.js);
      if (json.context_id) this.setContextId(json.context_id);
    //    if (this.json.hash) this._setHash();
    },

    replaceBody: function(html) {
      $("body").html(html);
      $('body').trigger('hammer.update') // FIXME trigger global event
    },

    evalJs: function(js) {
      eval(js);
    },

    setContextId: function(contextId) {
      hammer.settings.contextId = contextId;
    }

  //    setHash: function() {
  //      location.hash = this.json.hash;
  //    }
  }

  var hammer = {
    setupWebsocket: function() {
      if (!this.websocket) {
        this.websocket = new WebSocket("ws://" + this.settings.server + ":" + this.settings.port + "/");

        this.websocket.onmessage = function(evt) {
          hammer.safely( function() {
            logger.debug("recieving: " + evt.data);
            reciever.execute(JSON.parse(evt.data));
          // if (hammer.bench) hammer.callRandomAction();
          });
        };

        this.websocket.onclose = function() {
          hammer.noConnection()
        };
        this.websocket.onerror = function() {
          hammer.noConnection()
        };

        this.websocket.onopen = function() {
          logger.debug("WebSocket connected...");
          hammer.requestContent();
        };
      }
    },

    recieve: function(obj) {
      (new Hammer.Reciever(obj))._execute();
    },

    requestContent: function() {
      message().send();
    },

    noConnection: function() {
      alert('Connection to server was lost, click OK to reload.');
      location.reload();
    },

    settings: {
      set: function(obj) {
        $.extend(this, obj);
      },

      check: function() {
        if (!this.sessionId) throw Error('no sessionId')
        if (!this.server) throw Error('no server')
        if (!this.port) throw Error('no port')
      }
    },

    safely: function(func, obj) {
      try {
        return func.call(obj);
      } catch (e) {
        logger.error(e);
        logger.error(e.stack);
      }
    },

    Message: function() {
      this.session_id = hammer.settings.sessionId
      this.context_id = hammer.settings.contextId,
      this.hash = location.hash.replace(/^#/, '')
    }
  }

  hammer.Message.prototype = {
    send: function() {
      var json = JSON.stringify(this);
      logger.debug("sending: " + json);
      if(hammer.websocket) {
        hammer.websocket.send(json);
        _message = undefined;
      } else {
        throw Error('no websocket')
      }
    },

    setAction: function(id, args) {
      if (this.action_id)
        throw Error('already set');
      else {
        this.action_id = id;
        this.arguments = args;
      }
      return this;
    },

    setValue: function(componentId, key, value) {
      if (!this.form) this.form = {};
      if (!this.form[componentId]) this.form[componentId] = {};
      this.form[componentId][key] = value;
    }
  }

  var _message;
  function message() {
    if(_message)
      return _message;
    else
      return _message = new hammer.Message();
  }

  $.namespace('hammer', {
    inherited: true,
    action: function(id, args) {
      return this.each(function() {
        message().setAction(id || $(this).hammer.actionId(), args);
      });
    },

    send: function() {
      message().send();
      return this;
    },

    form: function() {
      this.each(function() {
        var formId = $(this).hammer.formId();
        if (formId) {
          $().hammer.component(formId).find('*').hammer.setValue();
        }
      });
      return this;
    },

    setSettings: function(settings) {
      hammer.settings.set(settings);
    },

    componentId: function() {
      return this.filter('.component').attr('id') || this.parents('.component').attr('id');
    },

    formId: function() {
      return this.attr('data-form-id');
    },

    component: function(id) {
      return $('#' + id || hammer.componentId);
    },

    setValue: function() {
      this.filter(':text,:radio,:checkbox,:password,:hidden,select,textarea').each(function() {
        var name = $(this).attr('name');
        if (name) message().setValue($(this).hammer.componentId(), name, $(this).val())
      });
      return this;
    },

    actionId: function() {
      return this.attr('data-action-id');
    },

    eval: function() {
      return this.each(function() {
        var elem = $(this)
        if (!elem.data('hammer.evaluated')) {
          eval(elem.attr('data-js'));
        }
        elem.data('hammer.evaluated', true)
      });
    }
  });

  $(function() {
    hammer.setupWebsocket();

    $('body').bind('hammer.update', function() {
      $('[data-js]').hammer.eval();
    });

    $(window).bind('hashchange', function(evt) {
      logger.warn("hashchange trigered")
      message().send();
    });

  });


})(jQuery);
