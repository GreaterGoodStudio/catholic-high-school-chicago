class CalendarEventCreator
  def initialize(events, school = nil)
    @events = Array(events)
    @cal = Icalendar::Calendar.new
    @cal_name = school || I18n.t(:title)
  end

  def perform
    setup_calendar
    set_time_zone
    add_events

    @cal
  end

  private

    def setup_calendar
      @cal.prodid = "-//#{@cal_name}//#{I18n.locale.upcase}"
    end

    def add_events
      @events.each do |event|
        e = Icalendar::Event.new
        e.dtstart = event.starts_at
        e.dtend = event.ends_at
        e.summary = "#{event.school || I18n.t(:title)}: #{event.name}"
        e.description = event.description

        @cal.add_event(e)
      end
    end

    def set_time_zone
      @cal.timezone do |t|
        t.tzid = "America/Chicago"

        t.daylight do |d|
          d.tzoffsetfrom = "-0600"
          d.tzoffsetto   = "-0500"
          d.tzname       = "CDT"
          d.dtstart      = "19700308T020000"
          d.rrule        = "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
        end

        t.standard do |s|
          s.tzoffsetfrom = "-0500"
          s.tzoffsetto   = "-0600"
          s.tzname       = "CST"
          s.dtstart      = "19701101T020000"
          s.rrule        = "FREQ=YEARLY;BYMONTH=11;BYDAY=1SU"
        end
      end
    end
end