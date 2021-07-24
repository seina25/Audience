module Members::ProgramNotificationsHelper
  def unchecked_notifications
    @notifications = current_member.program_notifications.where(checked: false)
  end
end
