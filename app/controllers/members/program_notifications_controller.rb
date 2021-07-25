class Members::ProgramNotificationsController < ApplicationController

  def index
    @programs =  current_member.today_favorite_programs
    # 既読した場合の通知マークの更新
    current_member.favorite_checked_update
  end


  #通知を全削除
  def destroy_all
    current_member.favorites.destroy_all
    redirect_to program_notifications_path
  end
end
