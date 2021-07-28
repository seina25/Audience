class Members::ReviewsController < ApplicationController

  def create
    @program = Program.find(params[:program_id])
    @comment = current_member.reviews.new(review_params)
    @comment.program_id = @program.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def edit
    @review = Review.find_by(id: params[:id], program_id: params[:program_id])
  end

  def update
    @review = Review.find_by(id: params[:id], program_id: params[:program_id])
    @review.update(review_params)
    redirect_to program_path(params[:program_id])
  end

  def destroy
    Review.find_by(id: params[:id], program_id: params[:program_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :score)
  end
end
