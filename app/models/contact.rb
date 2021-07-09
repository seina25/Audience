class Contact < ApplicationRecord
  belongs_to :member

  validates :title, presence: true, length: { in: 5..30 }
  validates :message, presence: true, length: { in: 10..300}
end
