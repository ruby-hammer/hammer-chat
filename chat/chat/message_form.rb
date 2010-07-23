module Chat
  class MessageForm < Hammer::Component::FormPart

    alias_method(:message, :record)

    class Widget < Hammer::Component::FormPart::Widget
      wrap_in :div
      
      def content
        cb.a("Send").event(:click).form.action! {
            if message.valid?
              message.time!
              answer!(message)
            end
          }
        widget Hammer::Widget::FormPart::Textarea, :value => :text, :options =>
            { :rows => 2, :class => %w[ui-widget-content ui-corner-all] }
        
      end
    end

  end
end