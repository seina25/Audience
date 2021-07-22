class Members::ProgramNotificationsController < ApplicationController

  def index
    @programs = current_member.program_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
    notification.update_attributes(checked: true)
    end
  end


end
