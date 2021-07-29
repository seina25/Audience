class Members::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @program = Program.find(params[:program_id])
    favorite = current_member.favorites.new(program_id: @program.id)
    if favorite.save
      redirect_back(fallback_location: root_path)
      flash[:notice] ="お気に入りの番組に追加しました。放送前に通知されます。"
    else
      flash[:alert] = "お気に入り登録ができませんでした。もう一度試してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @program = Program.find(params[:program_id])
    favorite = current_member.favorites.find_by(program_id: @program.id)
    if favorite.destroy
      redirect_back(fallback_location: root_path)
      flash[:notice] = "お気に入りを解除しました。この番組の通知はされません。"
    else
      flash[:alert] = "お気に入り解除ができませんでした。もう一度試してください。"
      redirect_back(fallback_location: root_path)
    end
  end
end
