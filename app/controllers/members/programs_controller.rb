class Members::ProgramsController < ApplicationController

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @time = Time.zone.now
    @program = Program.find(params[:id])
    @member = current_member
  end

  private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :cast, :channel,
    :start_datetime, :end_datetime, :by_weekday, :profile_image_id)
  end

end
