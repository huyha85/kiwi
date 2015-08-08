module CheckinsHelper
  def date_labels
    (NUMBER_OF_LAST_CHECKINS - 1).days.ago.to_date.upto(Date.today).map do |date|
      date_format(date)
    end
  end

  def checkin_times(checkins)
    (NUMBER_OF_LAST_CHECKINS - 1).days.ago.to_date.upto(Date.today).map do |date|
      get_checkin_hour_of_date(checkins, date)
    end
  end

  def get_checkin_hour_of_date(checkins, date)
    checkins.each do |checkin|
      if date_format(checkin.created_at_local_time) == date_format(date)
        return checkin.get_hour_in_float.round(2)
      end
    end
    0
  end

  def date_format(date)
    date.strftime(DATE_FORMAT)
  end
end
