# encoding: UTF-8

module Hammer::Widget

  # Abstract layout for Hammer applications
  class Layout < Erector::Widgets::Page

    #      depends_on :js, 'js/swfobject.js', 'js/FABridge.js', 'js/web_socket.js'
    external :js, 'js/jquery-1.4.2.js'
    external :js, 'js/jquery.ba-hashchange.js'
    external :js, 'js/hammer.js'
    external :css,  'css/developer.css'
      
    def body_content
      set_variables(@session_id)
      loading
    end

    # overwrite to change loading page
    def loading
      div(:class => 'loading') { img :src => 'img/loading.gif', :alt => "Loading..." }
    end

    private

    # sets configuration
    def set_variables(session_id)
      javascript("hammer._setVariables(%s);" % JSON[
          :server => Hammer.config[:websocket][:server],
          :port => Hammer.config[:websocket][:port],
          :sessionId => session_id,
          :sendLogBack => Hammer.config[:js][:send_log_back]
        ])
    end
  end
end