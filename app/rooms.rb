module Chat
  class Rooms < Hammer::Component::Base

    attr_reader :room, :room_form
    changing { attr_writer :room_form, :room  }
    shared :user, :user=

    after_initialize do
      shared.add_observer(:user_changed, self) do
        user_changed
      end
      user_changed
    end

    def user_changed
      unless user
        logout
        pass_on ask(Login.new(:record => Model::User.new)) { |user|
          File.open('users.log', 'a') { |f| f.write "#{user.nick}\t#{user.email}\n"  }
          self.user = user
        }
      else
        login
      end
      change!
    end

    def rooms_changed(room)
      change!
    end

    private

    def login
      retake_control!
      Chat::Model::Rooms.instance.add_observer(:new, self, :rooms_changed)
      Chat::Model::Rooms.instance.add_observer(:deleted, self, :rooms_changed)
    end

    def logout
      Chat::Model::Rooms.instance.delete_observer(:new, self)
      Chat::Model::Rooms.instance.delete_observer(:deleted, self)
    end

    class Widget < widget_class :Widget

      css do
        a { padding '0 0.2em' }
      end

      def content        
        h1 "Chat rooms", :class => 'grid_16'
        p :class => 'grid_16' do

          Model::Rooms.instance.rooms.each do |r|
            link_to("#{r.name}").action do
              self.room.try :leave!
              self.room = Chat::Room.new :room => r, :user => user
            end
          end

          link_to('Logout').action do
            self.user = nil
          end

          unless room_form
            link_to('New room').action do
              self.room_form = ask Chat::RoomForm.new(:record => Chat::Model::Room.new) do |room|
                Chat::Model::Rooms.instance.add_room(room) if room
                self.room_form = nil
              end
            end
          end
        end
        div :class => 'clear'

        if room_form
          render room_form
        end       

        render room if room
      end
    end

  end
end