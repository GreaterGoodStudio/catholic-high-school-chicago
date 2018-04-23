class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def show
    @intro = Intro.find_by(page: params[:id])
    super
  end
end
