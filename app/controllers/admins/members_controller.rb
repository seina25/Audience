class Admins::MembersController < ApplicationController

  def index
    @members = Member.all.page(params[:page]).per(20)
  end

  def show
    @member = Member.where(id: params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admins_members_path # snotice: '会員情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :kana_sei, :kana_mei, :nickname, :prefecture, :gender, :email, :password, :password_confirmation, :profile_image, :line_id)
  end
end
