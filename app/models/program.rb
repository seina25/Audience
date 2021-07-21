class Program < ApplicationRecord

  has_many :review, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :line_notices, dependent: :destroy

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end


  validates :title, presence: true
  validates :second_title, presence: true
  validates :category, presence: true
  validates :channel, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :by_weekday, presence: true

  enum by_weekday: { sun: 0, mon: 1, tue: 2, wed: 3, thu: 4, fri: 5, sat: 6 }

  attachment :program_image

  # 番組検索の処理
  def self.search(search)
    if search != ""
      Program.where(['title LIKE ? OR channel LIKE ? OR category LIKE ? OR cast LIKE ? OR by_weekday LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      #Review.where('gametitle LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%")
    else
      Program.all
    end
  end
end
