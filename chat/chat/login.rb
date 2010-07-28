# encoding: UTF-8

module Chat
  class Login < Hammer::Component::FormPart

    alias_method(:user, :record)

    class Widget < Hammer::Component::FormPart::Widget
      wrap_in :div
      
      def content
        p do
          h1 "Log in", :class => %w[ui-widget]
          text 'Name:'
          widget Hammer::Widget::FormPart::Input, :value => :nick, :options => 
              { :class => %w[ui-widget-content ui-corner-all] }
          text 'Email:'
          widget Hammer::Widget::FormPart::Input, :value => :email, :options =>
              { :class => %w[ui-widget-content ui-corner-all] }
          a "Log in", :callback => on(:click, component.form) { answer!(user) if user.valid? }
        end
      end
    end

  end
end