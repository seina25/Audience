class Program < ApplicationRecord
  has_many :program_favorites, dependent: :destroy
  has_many :review, dependent: :destroy

  has_many :casts, through: :program_casts
  has_many :program_casts, dependent: :destroy

  validates :title, presence: true
  validates :second_title, presence: true
  validates :category, presence: true
  validates :channel, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :by_weekday, presence: true
  validates :status, presence: true

  enum by_weekday: { sun: 0, mon: 1, tue: 2, wed: 3, thu: 4, fri: 5, sat: 6 }
  enum status: { 放送予定: 0, 放送中: 1, 放送終了:2 }
  attachment :program_image
end
