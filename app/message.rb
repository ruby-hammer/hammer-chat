module Chat
  class Message < Hammer::Component::Base
    needs :message
    attr_reader :message

    class Widget < widget_class :Widget
      require 'gravatarify'
      include Gravatarify::Helper

      css do
        img { margin_bottom '18px' }
        class!(:message) do
          margin_left '-5px'
          width '695px'
        end
      end

      def content
        div :class => %w{grid_1 alpha} do
          img :src => gravatar_url(message.user.email, :size => 36, :default => :wavatar), :alt => 'avatar'
        end

        p :class => %w{grid_12 message omega} do
          strong message.user
          text " - #{message.time.strftime('%H:%M:%S')}:"; br
          text "#{message.text}"
        end
        div :class => 'clear'
      end
    end
  end
end