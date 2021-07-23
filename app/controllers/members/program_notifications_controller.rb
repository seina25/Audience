class Members::ProgramNotificationsController < ApplicationController

  def index
    @programs = current_member.program_notifications.page(params[:page]).per(20)
    @notifications = ProgramNotification.today_favorite_program(current_member)
  end


end
