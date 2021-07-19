class Admins::ProgramsController < ApplicationController
  #require 'selenium-webdriver'

  include ProgramScrapesConcern


  def scrape
    @time = Time.zone.now
    set_scrape
    redirect_to admins_programs_path
    # @program = Program.find(program_params)
  end

  def new
  end

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @time = Time.zone.now
    @program = Program.find([:id])
  end

  def edit
  end

  def update
  end


private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :cast, :channel,
    :start_datetime, :end_datetime, :by_weekday, :profile_image_id)
  end

end