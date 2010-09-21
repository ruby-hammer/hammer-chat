# encoding: UTF-8

require 'digest'

class Chat::Model::User
  include DataMapper::Resource

  property :id, Serial
  property :nick, String, :required => true, :length => 3..20
  property :email, String, :required => true, :format => :email_address
  property :encripted_password, String, :required => true, :length => 64

  attr_accessor :password, :password_confirmation
  validates_length_of :password, :within => 6..20
  validates_confirmation_of :password

  has n, :rooms
  has n, :messages

  def to_s
    nick
  end

  before :valid?, :set_password
  after :save, :clear_text_passwords

  def self.login(nick, password)
    first(:nick => nick, :encripted_password => digest_password(password))
  end

  private

  def set_password
    self.encripted_password = self.class.digest_password(password)
  end

  def clear_text_passwords
    self.password = self.password_confirmation = nil
  end

  def self.digest_password(password)
    Digest::SHA256.hexdigest(password)
  end

end
