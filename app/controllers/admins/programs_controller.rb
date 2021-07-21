class Admins::ProgramsController < ApplicationController
  #require 'selenium-webdriver'

  include ProgramScrapesConcern


  def scrape
    @time = Time.zone.now
    # fivedays_later
    threedays_later
    # today_scrape
    redirect_to admins_programs_path
  end

  def new
  end

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @time = Time.zone.now
    @program = Program.find(params[:id])
  end

  def edit
    @program = Program.find(params[:id])
  end

  def update
    @program = Program.find(params[:id])
    @program.update(program_params)
    redirect_to admins_program_path(@program)
  end

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    redirect_to admins_programs_path
  end


private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :cast, :channel,
    :start_datetime, :end_datetime, :by_weekday, :profile_image_id)
  end

end