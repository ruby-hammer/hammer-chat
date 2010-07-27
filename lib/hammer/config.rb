# encoding: UTF-8

module Hammer
  module Config

    def self.included(base)
      base.extend ClassMethods
    end

    def config
      self.class.config
    end

    module ClassMethods
      def config
        @@config ||= begin c = Configliere.new({
              :web => {
                :host => '127.0.0.1',
                :port => 3000
              },
              :websocket => {
                :host => '127.0.0.1',
                :server => '127.0.0.1',
                :port => 3001,
                :debug => false,
                :fibers => 10,
              },
              :layout_class => 'Hammer::Widget::Layout',
              :environment => :development,
              :js => { :send_log_back => false },
              :logger => {
                :level => 0,
                :show_traffic => false,
                :output => $stdout
              },
              :erector => { :pretty => false },
              :core => { :devel => 'devel' }
            })

          c.use :env_var
          c.env_vars :environment => ENV['RACK_ENV']
          c.resolve!
    
          c.use :config_file
          c.read './config.yml'
          c.resolve!

          c.use :define
          c.define 'web.host', :require => true, :type => String
          c.define 'web.port', :require => true, :type => Integer
          c.define 'websocket.host', :require => true, :type => String
          c.define 'websocket.server', :require => true, :type => String
          c.define 'websocket.port', :require => true, :type => Integer
          c.define 'websocket.debug', :require => true, :type => :boolean
          c.define 'websocket.fibers', :require => true, :type => Integer
          c.define 'root_class', :require => true, :type => String
          c.define 'layout_class', :require => true, :type => String,
              :description => "Name of a layout class."
          c.define 'environment', :require => true, :type => Symbol
          c.define 'js.send_log_back', :require => true, :type => :boolean
          c.define 'logger.level', :require => true, :type => Integer
          c.define 'logger.show_traffic', :require => true, :type => :boolean
          c.define 'logger.output', :require => true
          c.define 'erector.pretty', :require => true, :type => :boolean
          c.define 'core.devel', :require => true, :type => String
          c.resolve!
  
          c.use :commandline
          c.resolve!
          c
        end
      end
    end
  end
end



