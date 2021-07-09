class Cast < ApplicationRecord
  has_many :cast_favorites, dependent: :destroy

  has_many :programs, throuth: :program_casts
  has_many :program_casts, dependent: :destroy

  validates :name, presence: true
  validates :occupation, presence: true
  validates :cast_image_id, presence: true

  attachment :cast_image_id
end
