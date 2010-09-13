class Chat::Shared < Hammer::Core::Shared
  attr_reader :user

  observable_events :user_changed

  def user=(user)
    @user = user
    notify_observers(:user_changed)
  end

end