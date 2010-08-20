# encoding: UTF-8

module Chat
  class Login < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:user, :record)

    define_widget do
      wrap_in :div
      def wrapper_classes
        super << 'container' << 'form'
      end

      def content
        h1 "Log in"

        label 'Nick:', :for => @label_id = Hammer::Core.generate_id, :class => 'span-3 inline'
        div :class => %w{span-21 last}, :style => 'height: 36px;' do
          input :name => :nick, :value => value(:nick), :type => :text, :id => @label_id
        end

        label 'Gravatar email:', :for => @label_id = Hammer::Core.generate_id, :class => 'span-3 inline'
        div :class => %w{span-21 last}, :style => 'height: 36px;' do
          input :name => :email, :value => value(:email), :type => :text, :id => @label_id
        end

        div :class => %w{span-21 prepend-3 last}, :style => 'height: 36px;' do
          submit("Log in").update { answer!(user) if user.valid? }
        end
      end
    end

  end
end