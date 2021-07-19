# frozen_string_literal: true

class Members::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # 退会機能（退会済みnユーザのログイン阻止）
  def reject_inactive_member
    # 入力されたメールアドレスに対応するユーザーが存在するかを確認する
    @member = Member.find_by(email: params[:member][:email])
    if @member
      # 入力されたパスワードが正しい場合かつ、modelで定義したメソッドの返り値がtrueだった場合は、ログイン処理を行わずにログイン画面に遷移する。
      if @member.valid_password?(params[:member][:password]) && !@member.is_valid
        redirect_to new_user_session_path
      end
    end
  end
end
