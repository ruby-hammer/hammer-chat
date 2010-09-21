class Chat::Model::Message
  include DataMapper::Resource

  property :id, Serial
  property :text, Text, :required => true, :lazy => false
  property :time, DateTime

  belongs_to :user
  belongs_to :room

  before :save do
    @was_new = new?
  end

  after :save do
    room.notify_observers(:message_created, self) if @was_new
  end

end