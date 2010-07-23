module Hammer::Core

  @last_id = 0
  def self.generate_id
    #      UUID.generate(:compact).to_i(16).to_s(36)
    (@last_id+=1).to_s(36)
  end

end