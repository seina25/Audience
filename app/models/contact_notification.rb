class ContactNotification < ApplicationRecord
  belongs_to :contact
  belongs_to :admin

  def self.contact_confirmed
    unchecked_notifications = where(checked: false)
    unchecked_notifications.each do |un|
      un.update!(checked: true)
    end
  end
end
