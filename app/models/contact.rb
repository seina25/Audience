class Contact < ApplicationRecord
  belongs_to :member
  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: { in: 3..30 }
  validates :message, presence: true, length: { in: 5..300}
end
