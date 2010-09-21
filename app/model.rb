module Chat::Model
  def self.models
    constants.map {|name| const_get name }.select {|c| c.kind_of? Class && c < DataMapper::Resource }
  end
end