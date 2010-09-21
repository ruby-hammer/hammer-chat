module Chat
  class Rooms < Hammer::Component::Base

    attr_reader :room, :room_form, :a_form
    changing { attr_writer :room, :room_form, :a_form  }

    shared :user, :user=

    Struct.new("User", :nick, :password)

    after_initialize do
      shared.add_observer(:user_changed, self) { change! }
      Chat::Model::Room.add_observer(:created, self) { change! }
      Chat::Model::Room.add_observer(:edited, self) { change! }
      Chat::Model::Room.add_observer(:destroyed, self) { change! }
      new_room
    end

    private

    def new_room
      self.room_form = ask Chat::RoomForm.new(:record => Chat::Model::Room.new) do |room|
        room.save
        new_room
      end
    end

    class Widget < widget_class :Widget
      css do
        class!(:menu) {
          border_right '5px solid #EFE7DA'
          padding '0 10px'
        }
        class!(:menu) >> class!(:rooms) >> li {
          list_style_type 'square'
          margin_left '20px'
        }
        class!(:menu) >> class!(:rooms) {
          margin_bottom 0
        }
      end

      def content
        div(:class => %w[grid_3]) { menu }
        div(:class => %w[grid_13]) { main }
        div :class => 'clear'
      end

      def menu
        div :class => 'menu' do
          h1 "Chat"
          ul do
            unless user
              li do
                link_to('Sign in').action do
                  self.a_form = ask(UserForm.new(:record => Model::User.new, :title => 'Sign in')) do |user|
                    if user
                      user.save!
                      self.user = user
                    end
                    self.a_form = nil
                  end
                end
              end

              li do
                link_to('Login').action do
                  self.a_form = ask(Login.new(:record => Struct::User.new)) do |user|
                    if user
                      self.user = user
                    end
                    self.a_form = nil
                  end
                end
              end
            else
              li do
                link_to("Logout '#{user}'").action do
                  self.user = nil
                end
              end

              li do
                link_to("Edit '#{user}'").action do
                  self.a_form = ask(UserForm.new(:record => user, :title => 'Edit my profile')) do |user|
                    if user
                      user.save!
                      self.user = user
                    end
                    self.a_form = nil
                  end
                end
              end
            end
          end

          h2 "Rooms"
          ul :class => 'rooms' do
            Model::Room.all.each do |r|
              li do
                link_to("#{r.name}").action do # FIXME when img in link event on click does not fire
                  self.room.try :leave!
                  self.room = Chat::Room.new :room => r
                end
                text ' '
                link_to('delete').action do
                  r.messages.destroy
                  r.destroy
                  self.room = nil if self.room.try(:room) == r
                end if r.user == user
              end
            end
          end
          render room_form if user
        end
      end

      def main
        render a_form || room
      end

    end
  end
end