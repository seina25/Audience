class Members::ProgramsController < ApplicationController

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(5).order(created_at: :desc)
    @member = current_member
    @search_params = program_search_params
  end

  def show
    @time = Time.zone.now
    @member = current_member
    @program = Program.find(params[:id])
      unless ViewCount.find_by(member_id: current_member.id, program_id: @program.id)
        current_member.view_counts.create(program_id: @program.id)
      end
    @review = Review.new
    @reviews = @program.reviews.order(created_at: :desc)
  end

  def search
    # @programs = Program.search(params[:keyword])
    @search_params = program_search_params
    @programs = Program.search(@search_params)
  end

  private

  def program_params
    params.require(:program).permit(:title, :second_title, :category, :talent, :channel,
    :start_datetime, :end_datetime, :by_weekday, :program_image, :keyword, :impressionist)
  end

  def program_search_params
    params.fetch(:search, {}).permit(:keyword, :start_datetime_from, :start_datetime_in_to)
  end

end
