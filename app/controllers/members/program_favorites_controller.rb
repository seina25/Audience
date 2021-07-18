class Members::ProgramFavoritesController < ApplicationController
  def create
    program = Program.find(params[:program_id])
    favorite = current_member.favorites.new(program_id: program.id)
    favorite.save
    redirect_to program_path(program)
  end

  def destroy
    program = Program.find(params[:program_id])
    favorite = current_member.favorite.find_by(program_id: program.id)
    favorite.destroy
    redirect_to program_path(program)
  end
end
