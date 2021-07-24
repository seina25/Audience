class Members::ProgramNotificationsController < ApplicationController

  def index
    @programs = current_member.program_notifications
    @notifications = ProgramNotification.today_favorite_program(current_member)
  end
  
  def destroy_all
  #通知を全削除
    @notifications = current_member.program_notifications.destroy_all
    redirect_to program_notifications_path
  end



end
