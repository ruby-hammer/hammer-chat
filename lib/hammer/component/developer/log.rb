# encoding: UTF-8

module Hammer
  module Component
    module Developer
      class Log < Hammer::Component::Base

        attr_reader :messages

        after_initialize do
          @messages = []
          @limit = 200

          # observe log :message event
          Hammer.logger.add_observer(:message, self, :new_message)

          # listen context for :drop event then delete observer to collect by GC
          context.add_observer(:drop) { Hammer.logger.delete_observer :message, self }
        end

        def new_message(message)
          Hammer.logger.silence(5) do # we don't want to end up in infinite loop
            context.schedule do
              Hammer.logger.silence(5) do
                add_message(message)
                context.actualize.send!
              end
            end
          end
        end

        private

        def add_message(message)
          @messages.unshift message
          @messages.pop if @messages.size > @limit
        end

        class Widget < Hammer::Widget::Base
          wrap_in(:div)

          def content
            h3 'Log'

            p "objects observing: #{Hammer.logger.count_observers(:message)}"

            component.messages.each do |message|
              p :class => odd do
                text message
              end
            end
          end

          def odd
            (@odd = !@odd) ? 'odd' : 'even'
          end

        end

      end

    end
  end
end
