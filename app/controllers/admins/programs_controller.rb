class Admins::ProgramsController < ApplicationController
  #require 'selenium-webdriver'

  include ProgramScrapesConcern


  def scrape
    @time = Time.zone.now
    program_information_acquisition
    render :scrape
    # @program = Program.find(program_params)
  end

  def new
  end

  def index
    @time = Time.zone.now
    @programs = Program.all
  end

  def edit
  end

  def update
  end


private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :cast, :channel,
    :start_datetime, :end_datetime, :by_weekday, :profile_image_id, :status)
  end

end