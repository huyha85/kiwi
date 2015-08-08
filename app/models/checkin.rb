class Checkin
  include Mongoid::Document
  include Mongoid::Timestamps

  MAX_CHECKINS_PER_PAGE = 25

  belongs_to :user

  delegate :email, to: :user, prefix: true

  def self.toggle_checkin(email)
    user = User.with_whitelist_domain_email(email)
    user ? create_today_checkin(user) : nil
  end

  def self.create_today_checkin(user)
    where(user: user, :created_at.gte => Time.now.beginning_of_day).first_or_create
  end
end
