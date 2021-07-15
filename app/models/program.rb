class Program < ApplicationRecord
  has_many :program_favorites, dependent: :destroy
  has_many :review, dependent: :destroy

  has_many :casts, through: :program_casts
  has_many :program_casts, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :by_weekday, presence: true
  validates :by_time, presence: true
  validates :program_image_id, presence: true
  validates :status, presence: true
  validates :goods, presence: true

  enum by_weekday: { sun: 0, mon: 1, thu: 2, wed: 3, ted: 4, fry: 5, sat: 6 }
  enum status: { 放送未定: 0, 放送中: 1, 放送終了:2 }
  attachment :program_image
end
