# encoding: UTF-8

module Hammer::Component::Developer
  class Tools < Hammer::Component::Base
    
    attr_reader :tool

    class Widget < Hammer::Widget::Base
      def content
        strong 'Tools:'
        ul do
          li { a "Log", :callback => on(:click) { @tool = new Hammer::Component::Developer::Log } }
          li { a "Inspector Hammer::Core::Base", :callback => on(:click) { @tool = inspector Hammer::Core::Base } }
          li { a "Inspector Object", :callback => on(:click) { @tool = inspector Object } }
          li { a "Inspector Hammer.logger", :callback => on(:click) { @tool = inspector Hammer.logger } }
          li do
            a "Inspector Chat::Model::Room.rooms", :callback => on(:click) { @tool = inspector Chat::Model::Room.rooms }
          end if defined? Chat::Model::Room
          li { a "GC and stats", :callback => on(:click) { @tool = new Hammer::Component::Developer::Gc } }
          if defined? Memprof
            li { a "Memprof dump all", :callback => on(:click) { Memprof.dump_all("heap_dump.json") } }
          end
          li { a "none", :callback => on(:click) { @tool = nil } }
        end
      
        hr

        render tool if tool
      end
    end

  end
end
  
