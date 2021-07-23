class Members::FavoritesController < ApplicationController
  def create
    @program = Program.find(params[:program_id])
    favorite = current_member.favorites.new(program_id: @program.id)
    favorite.save
    @notification = current_member.program_notifications.new()
    @notification.program_id = @program.id
    # @notification.start_datetime = @program.start_datetime.ago(current_member.notification_time.hours) #通知時間を番組の時間 - ユーザの通知してほしい時間で
    @notification.favorite = favorite
    @notification.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @program = Program.find(params[:program_id])
    favorite = current_member.favorites.find_by(program_id: @program.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
