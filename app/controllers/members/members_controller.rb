class Members::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = current_member
    @favorites = Favorite.where(member_id: @member.id)
    @reviews = @member.reviews.all
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to my_page_path, notice: '会員情報を更新しました。'
    else
      flash.now[:alert] = '会員情報の更新に失敗しました。'
      render :edit
    end
  end

  def unsubscribe
    @member = current_member
  end

  def withdraw
    @member = current_member
    @member.update(is_valid: '退会済')
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def notification
    @member = current_member
  end

  def notification_update
    @member = current_member
    if @member.update(member_params)
      redirect_to my_page_path, notice: '通知時間を変更しました。'
    else
      flash.now[:alert] = '通知の更新に失敗しました。'
      render :notification
    end
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :kana_sei, :kana_mei, :nickname,
                                   :prefecture, :gender, :email, :password, :password_confirmation, :profile_image, :notification_time)
  end
end
