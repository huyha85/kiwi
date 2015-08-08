class Checkin
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  def self.toggle_checkin(email)
    #TODO: Associate to User with matching email
    create
  end
end
