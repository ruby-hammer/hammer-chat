module Chat
  class MessageForm < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:message, :record)

    on_submit do
      message.user = shared.user
      message.time = Time.now
      if message.valid?
        answer!(message)
      end
    end

    class Widget < widget_class :Widget
      css { input { width '100%' }}

      def content
        div :class => %w{grid_11 alpha} do
          render Hammer::Widget::Form::Field.new :component => component, :value => :text
        end
        div :class => %w{grid_2 omega} do
          input :type => :submit, :value => "Send"
        end
        div :class => 'clear'
      end
    end

  end
end