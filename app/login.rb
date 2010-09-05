# encoding: UTF-8

module Chat
  class Login < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:user, :record)
    on_submit { answer!(user) if user.valid? }

    class Widget < widget_class :Widget
      def wrapper_classes
        super << 'container' << 'form'
      end

      def content
        h1 "Log in"

        render Chat::Widget::Field.new :component => component, :value => :nick, :label => 'Nick:'
        render Chat::Widget::Field.new :component => component, :value => :email, :label => 'Gravatar email:'

        div :class => %w{span-21 prepend-3 last}, :style => 'height: 36px;' do
          input :type => :submit, :value => "Log in"
        end
      end
    end

  end
end