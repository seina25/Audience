class Admins::ContactsController < ApplicationController
  # before_action :authenticate_member!

  def index
    @contacts = Contact.all.page(params[:page]).per(20).order(created_at: :desc)
    @members = Member.all

    # お問合せ新着データの通知としてモデルに定義
    # Notification.confirmed
  end

  def show
    @contact = Contact.find(params[:id])
  end

  private
    def contact_params
        params.require(:contact).permit(:title, :message)
    end

end
