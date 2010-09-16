# encoding: UTF-8

module Chat
  class Login < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:user, :record)
    on_submit { answer!(user) if user.valid? }

    class Widget < widget_class :Widget
      def content
        h1 "Log in", :class => 'grid_16'

        render Chat::Widget::Field.new :component => component, :value => :nick, :label => 'Nick:'
        render Chat::Widget::Field.new :component => component, :value => :email, :label => 'Gravatar email:'        

        div :class => %w{prefix_2 grid_2} do
          input :type => :submit, :value => "Log in"
        end
        div :class => 'clear'
      end
    end

  end
end