class Checkin
  include Mongoid::Document
  include Mongoid::Timestamps

  MAX_CHECKINS_PER_PAGE = 25

  belongs_to :user

  delegate :email, to: :user, prefix: true, allow_nil: true

  default_scope -> { order_by('created_at desc') }

  def self.toggle_checkin(email)
    user = User.with_whitelist_domain_email(email)
    user ? create_today_checkin(user) : nil
  end

  def self.create_today_checkin(user)
    where(user: user, :created_at.gte => Time.now.beginning_of_day).first_or_create
  end

  def get_hour_in_float
    created_at.strftime('%H').to_i + created_at.strftime('%M').to_f / 60
  end
end
