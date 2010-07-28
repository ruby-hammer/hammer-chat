module Chat
  class Rooms < Hammer::Component::Base

    attr_reader :room, :user, :room_form

    after_initialize do      
      pass_on ask(Login.new(:record => Model::User.new)) { |user|
        @user = user
        File.open('users.log', 'a') { |f| f.write "#{@user.nick}\t#{@user.email}\n"  }
        retake_control!
      }
    end

    class Widget < Hammer::Widget::Base
      wrap_in :div
      
      def content

        h1 "Chat rooms"

        Model::Room.rooms.each do |r|
          a "#{r.name} (#{r.messages.size})",
              :callback => on(:click) { @room.try :leave!; @room = Chat::Room.new :room => r, :user => user }
        end

        unless room_form
          a 'new room', :callback => on(:click) {
            @room_form = ask Chat::RoomForm.new(:record => Chat::Model::Room.new) do |room|
              Chat::Model::Room.rooms << room if room
              @room_form = nil
            end
          }
        else
          render room_form
        end

        render room if room
      end
    end

  end
end