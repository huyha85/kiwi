class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email, type: String

  has_many :checkins

  validates :email, presence: true, uniqueness: true
end
