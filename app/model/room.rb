class Chat::Model::Room
  include DataMapper::Resource
  include Hammer::Core::Observable

  property :id, Serial
  property :name, String, :required => true, :length => 3..20

  belongs_to :user
  has n, :messages

  class_observable_events :created, :destroyed, :edited

  after :save do
    if new?
      self.class.notify_observers(:created, self)
    else
      self.class.notify_observers(:edited, self)
    end
  end

  after :destroy do
    self.class.notify_observers(:destroyed, self)
  end

  def to_s
    name
  end
end
