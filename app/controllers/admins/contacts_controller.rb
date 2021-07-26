class Admins::ContactsController < ApplicationController
  # before_action :authenticate_member!
  def index
    @contacts = Contact.all.order(created_at: :desc)
    ContactNotification.contact_confirmed
  end

  def show
    @contact = Contact.find(params[:id])
  end

  private
    def contact_params
        params.require(:contact).permit(:title, :message)
    end

end
