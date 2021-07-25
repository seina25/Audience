class Members::FavoritesController < ApplicationController
  def create
    @program = Program.find(params[:program_id])
    favorite = current_member.favorites.new(program_id: @program.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @program = Program.find(params[:program_id])
    favorite = current_member.favorites.find_by(program_id: @program.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
