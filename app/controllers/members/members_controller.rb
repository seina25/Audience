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
      redirect_to my_page_path # notice: '会員情報を更新しました。'
    else
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
    redirect_to root_path
  end

  def notification
    @member = current_member
  end

  def notification_update
    @member = current_member
    @member.update(member_params)
    redirect_to my_page_path
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :kana_sei, :kana_mei, :nickname,
    :prefecture, :gender, :email, :password, :password_confirmation, :profile_image, :notification_time)
  end


end
