class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String

  has_many :checkins

  validates :email, presence: true, uniqueness: true

  def self.with_whitelist_domain_email(email)
    email.match(whitelist_domain_regex) ? where(email: email).first_or_create : nil
  end

  def self.whitelist_domain_regex
    /\A([\w+\-].?)+@#{ENV['email_domain']}\z/i
  end
end
