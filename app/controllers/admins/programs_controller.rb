class Admins::ProgramsController < ApplicationController
  include ProgramScrapesConcern


  def index
    @time = Time.zone.now
    selection = params[:sort]
    @programs = Program.sort(selection).page(params[:page]).per(20)
    @sort = Program.program_selected_sort(selection)
    @search_params = program_search_params
  end

  def show
    @time = Time.zone.now
    @program = Program.find(params[:id])
    @favorite = Favorite.where(program_id: @program.id)
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

  def search
    @search_params = program_search_params
    @programs = Program.search(@search_params)
  end

  # スクレイピング用アクション
  def scrape
    # fivedays_later
    # threedays_later
    today_scrape
    redirect_to admins_programs_path
  end

private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :talent, :channel,
    :start_datetime, :end_datetime, :by_weekday, :profile_image_id)
  end

  def program_search_params
    params.fetch(:search, {}).permit(:keyword, :start_datetime_from, :start_datetime_to)
  end

end