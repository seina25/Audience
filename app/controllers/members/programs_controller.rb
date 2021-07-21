class Members::ProgramsController < ApplicationController

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(20).order(created_at: :desc)
    @member = current_member
  end

  def show
    @time = Time.zone.now
    @program = Program.find(params[:id])
    @member = current_member
    @review = Review.new
    @reviews = @program.review.order(created_at: :desc)
  end

  def search
    @programs = Program.search(params[:keyword])
  end

  private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :talent, :channel,
    :start_datetime, :end_datetime, :by_weekday, :program_image, :keyword)
  end

end
