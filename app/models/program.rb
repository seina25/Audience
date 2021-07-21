class Program < ApplicationRecord

  has_many :review, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
      Program.where(['title LIKE ? OR channnel LIKE ? OR category LIKE ? OR cast LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      #適切なオブジェクト名.where(['検索したいカラム名 ? OR 検索したいカラム名 LIKE ? OR 検索したいカラム名 LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
      #Review.where('gametitle LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%")
    else
      Program.all
    end
  end
end
