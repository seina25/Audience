class Admins::ContactsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @contacts = Contact.all.order(created_at: :desc)
  end

  private
    def contact_params
      params.require(:contact).permit(:title, :message)
    end
end
