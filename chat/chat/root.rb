# encoding: UTF-8

module Chat
  class Root < Hammer::Component::Base
    attr_reader :user

    after_initialize do
      unless @user
        pass_on ask(Login, :record => Model::User.new) { |user|
          @user = user
          File.open('users.log', 'a') { |f| f.write "#{@user.nick}\t#{@user.email}\n"  }
          pass_on new(Chat::Rooms, :user => @user)
        }
      else
        pass_on new(Chat::Rooms, :user => @user)
      end
    end
  end
end