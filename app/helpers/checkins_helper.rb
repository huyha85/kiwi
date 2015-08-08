module CheckinsHelper
  def date_labels
    Date.today.downto(Date.today - 9.days).map do |date|
      date_format(date)
    end
  end

  def checkin_times(checkins)
    Date.today.downto(Date.today - 9.days).map do |date|
      get_checkin_hour_of_date(checkins, date)
    end
  end

  def get_checkin_hour_of_date(checkins, date)
    checkins.each do |checkin|
      if date_format(checkin.created_at) == date_format(date)
        return checkin.get_hour_in_float
      end
    end
    0
  end

  def date_format(date)
    date.strftime('%d/%m/%y')
  end
end
