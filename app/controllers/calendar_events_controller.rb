class CalendarEventsController < ApplicationController
  before_action :find_school

  def index
    events = CalendarEvent.for_school(@school)
    filename = "#{@school.slug}.ics"

    render_ics events, filename
  end

  def show
    event = CalendarEvent.find(params[:id])
    filename = @school ? "#{@school.slug}_#{params[:id]}.ics" : "chsc_#{params[:id]}.ics"

    render_ics event, filename
  end

  private

    def find_school
      @school = School.friendly.find(params[:school_id]) if params[:school]
    end

    def render_ics(events, filename)
      cal = CalendarEventCreator.new(events, @school).perform

      send_data cal.to_ical, type: "text/calendar", disposition: "attachment", filename: filename
    end
end
