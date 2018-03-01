module CalendarEventHelper
  def date_range(from_date, until_date, options = {})
    options.symbolize_keys!
    format = options[:format] || :long
    separator = options[:separator] || "–"

    day_names = I18n.t("date.day_names")
    month_names = I18n.t("date.month_names")

    from_time = from_date.strftime("%I:%M %p")
    from_day = from_date.day
    from_dow = day_names[from_date.wday]
    from_month = month_names[from_date.month]
    from_year = from_date.year
    until_day = until_date.day
    until_time = until_date.strftime("%I:%M %p")

    dates = { from_day: from_day }

    if from_date.beginning_of_day == until_date.beginning_of_day
      date_format = "same_day"
      dates.merge!(dow: from_dow, month: from_month, year: from_year, from_time: from_time, until_time: until_time)
    elsif from_date.month == until_date.month && from_date.year == until_date.year
      date_format = "same_month"
      dates.merge!(until_day: until_day, month: from_month, year: from_year)
    else
      until_month = month_names[until_date.month]

      dates.merge!(from_month: from_month, until_month: until_month, until_day: until_day)

      if from_date.year == until_date.year
        date_format = "different_months_same_year"
        dates.merge!(year: from_year)
      else
        until_year = until_date.year

        date_format = "different_years"
        dates.merge!(from_year: from_year, until_year: until_year)
      end
    end

    I18n.t("date_range.#{date_format}", dates.merge(sep: separator))
  end
end
