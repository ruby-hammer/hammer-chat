# encoding: UTF-8

module Chat
  class Login < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:user, :record)
    attr_reader :error

    on_submit do
      if logged_user = Model::User.login(user.nick, user.password)
        answer!(logged_user)
      else
        @error = true
      end
    end

    class Widget < widget_class :Widget
      def wrapper_classes
        super << 'grid_13'
      end

      def content
        h1 "Log in"

        if component.error
          p 'Wrong nick or password, please try again.'
        end

        render Chat::Widget::Field.new :component => component, :value => :nick, :label => 'Nick:'
        render Chat::Widget::Password.new :component => component, :value => :password, :label => 'Password'

        div :class => %w{prefix_2 grid_3 alpha} do
          input :type => :submit, :value => "Log in"
          text ' '
          link_to('Cancel').action { answer! }
        end
        div :class => 'clear'
      end
    end

  end
end