class Members::HomesController < ApplicationController
  def top; end

  def about
    @favorite_top = Program.find(Favorite.group(:program_id).order(Arel.sql('count(program_id) desc')).pluck(:program_id)).first
    @review_top = Program.find(Review.group(:score).order('avg(score) desc').pluck(:program_id)).first
    @pv_top = Program.find(ViewCount.group(:program_id).order(Arel.sql('count(program_id) desc')).pluck(:program_id)).first
    @recommendation = Program.where(start_datetime: DateTime.now..Float::INFINITY).where('id >= ?',
                                                                                         rand(Program.first.id..Program.last.id)).first
  end
end
