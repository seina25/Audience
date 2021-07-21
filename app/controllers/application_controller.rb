class ApplicationController < ActionController::Base
  # before_action :check_notifications
  
  # 未読のお問合せがあれば通知（表示）される
  # def check_notifications
  #   @unchecked_notifications = Notification.where(checked:false)
  # end

   private

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admins_root_path
    else
      my_page_path
    end
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_member_session_path
    end
  end

end
