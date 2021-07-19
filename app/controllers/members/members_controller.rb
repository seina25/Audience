class Members::MembersController < ApplicationController
  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to my_page_path # snotice: '会員情報を更新しました。'
    else
      render :edit
    end
  end

  def unsubscribe
    @member = Member.find_by(email: params[:email])
  end

  def withdraw
    @member = Member.find_by(email: params[:email])
    @member.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  def line
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :kana_sei, :kana_mei, :nickname, :prefecture, :gender, :email, :password, :password_confirmation, :profile_image, :line_id)
  end


end
