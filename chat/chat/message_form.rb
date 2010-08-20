module Chat
  class MessageForm < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:message, :record)

    define_widget do
      wrap_in :div

      def wrapper_classes
        super << 'form'
      end

      css do
        input do
          width '100%'
          margin '6px 0'
        end
      end

      def content
        div :class => %w{span-22}, :style => 'height: 36px;' do
          input :name => :text, :value => value(:text), :type => :text
        end
        div :class => %w{span-2 last}, :style => 'height: 36px;' do
          submit("Send").update do
            if message.valid?
              message.time!
              answer!(message)
            end
          end
        end
      end
    end

  end
end