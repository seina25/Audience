class Members::ContactsController < ApplicationController

  def index
    @contacts = current_member.contacts.all
  end

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = current_member.contacts.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  def back
    @contact = current_member.contacts.new(contact_params)
    render :new
  end

  def create
    @contact = current_member.contacts.new(contact_params)
    @contact.member_id = current_member.id
    if @contact.save
      redirect_to contacts_thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :message)
  end

end
