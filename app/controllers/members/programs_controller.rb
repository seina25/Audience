class Members::ProgramsController < ApplicationController

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(5).order(created_at: :desc)
    @member = current_member
  end

  def show
    @time = Time.zone.now
    @member = current_member
    @program = Program.find(params[:id])
    @review = Review.new
    @reviews = @program.reviews.order(created_at: :desc)
  end

  def search
    @programs = Program.search(params[:keyword])
  end

  private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :talent, :channel,
    :start_datetime, :end_datetime, :by_weekday, :program_image, :keyword, :impressionist)
  end

end
# indexのviewでlink_to(remote: true)
# If params[:sort] == “いいね順”
# @programs = Program.all.いいね潤order
# Elsif params[:sort] == “pv”
# @programs = Program.all.pv潤
# end