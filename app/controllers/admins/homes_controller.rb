class Admins::HomesController < ApplicationController
  def top
  end

  def analysis
    @favorites = Favorite.count
    @reviews = Review.count
    @accesses = Member.all.sum(:sign_in_count)
    @view_counts = ViewCount.count
  end
end
