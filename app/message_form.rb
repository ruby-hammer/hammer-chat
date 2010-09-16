module Chat
  class MessageForm < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:message, :record)

    on_submit do
      if message.valid?
        message.time!
        answer!(message)
      end
    end

    class Widget < widget_class :Widget
      css { input { width '100%' }}

      def content
        div :class => %w{grid_14} do
          render Hammer::Widget::Form::Field.new :component => component, :value => :text
        end
        div :class => %w{grid_2} do
          input :type => :submit, :value => "Send"
        end
        div :class => 'clear'
      end
    end

  end
end