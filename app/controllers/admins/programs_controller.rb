class Admins::ProgramsController < ApplicationController
  include ProgramScrapesConcern


  def scrape
    # fivedays_later
    threedays_later
    # today_scrape
    redirect_to admins_programs_path
  end

  def new
  end

  def index
    @time = Time.zone.now
    @programs = Program.all.page(params[:page]).per(20).order(params[:sort])
    # @programs = Program.find(Review.group(:program_id).order('count(program_id) desc').pluck(:program_id))
    # @all_ranks = Note.find(Like.group(:note_id).order('count(note_id) desc').limit(3).pluck(:note_id))

    # レビューの評価平均値
    @reviews = Review.group(:program_id).average(:score)
    # レビューに紐づく番組を全て取得しレビューがない場合はnullで取得。distinctで重複レコードを回避し、配列を小さい順に並び替える
    # @programs = Program.left_joins(:reviews).distinct.sort_by do |program|
    #   reviews = program.reviews
    #   if reviews.present?
    #     # scoreの値だけ、追加していく
    #     reviews.map(&:score).sum / reviews.size
    #   else
    #     0
    #   end
    # end

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
    params.require(:program).permit(:title, :second_title, :category, :talent, :channel,
    :start_datetime, :end_datetime, :by_weekday, :profile_image_id)
  end

end