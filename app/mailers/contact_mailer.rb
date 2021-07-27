class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    # @contact.full_name = Contact.joins(:member).select("full_name")
    mail(
      from: 'system@example.com',
      to:   'replace421@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end
