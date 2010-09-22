class Chat::Model::Message
  include DataMapper::Resource
  include Hammer::Core::Observable

  property :id, Serial
  property :text, Text, :required => true, :lazy => false
  property :time, DateTime

  belongs_to :user
  belongs_to :room

  before :save do
    @was_new = new?
  end

  class_observable_events(:created)

  after :save do
    room.class.notify_observers(:created, room_id, id) if @was_new
  end

end