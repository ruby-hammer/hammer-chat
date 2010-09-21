# encoding: UTF-8

module Chat
  class UserForm < Hammer::Component::Base

    include Hammer::Component::Form

    alias_method(:user, :record)
    on_submit { answer!(user) if user.valid? }

    attr_reader :title
    needs :title

    class Widget < widget_class :Widget
      def wrapper_classes
        super << 'grid_13'
      end

      def content
        h1 component.title

        unless user.errors.blank?
          h2 'There are some errors:'
          ul do
            user.errors.full_messages.each do |message|
              li message
            end
          end
        end

        render Chat::Widget::Field.new :component => component, :value => :nick, :label => 'Nick:'
        render Chat::Widget::Field.new :component => component, :value => :email, :label => 'Gravatar email:'
        render Chat::Widget::Password.new :component => component, :value => :password, :label => 'Password:'
        render Chat::Widget::Password.new :component => component, :value => :password_confirmation,
            :label => 'Password again:'

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