module Chat
  class Message < Hammer::Component::Base
    needs :message
    attr_reader :message
    define_widget do
      require 'gravatarify'
      include Gravatarify::Helper

      def wrapper_classes
        super << %w[message ui-corner-all]
      end

      def content
        img :src => gravatar_url(message.user.email, :size => 32, :default => :wavatar), :alt => 'avatar'
        span(:class => :time) { text message.time.strftime('%H:%M:%S') }
        strong "#{message.user}: "
        text "#{message.text}"
      end
    end
  end
end