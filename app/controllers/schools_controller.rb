class SchoolsController < ApplicationController
  def index
    @query = school_params[:q]
    @schools = (@query ? School.where("name ILIKE ?", "%#{@query}%") : School.all).order(:name)
  end

  def show
    @school = School.friendly.find(params[:id])
    @calendar_events = CalendarEvent.upcoming.for_school(@school)
  end

  private

    def school_params
      params.permit(:q)
    end
end
