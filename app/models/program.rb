class Program < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :fav_members, through: :favorites, source: :member
  has_many :memberes, through: :favorites
  has_many :reviews, dependent: :destroy
  has_many :view_counts, dependent: :destroy


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
      Program.where(['title LIKE ? OR channel LIKE ? OR category LIKE ? OR talent LIKE ?',"%#{search}%", "%#{search}%","%#{search}%","%#{search}%"])
    else
      Program.all
    end
  end

  # def self.today
  #   Program.where(start_datetime: Time.zone.now.all_day)
  # end

  # 評価の平均値
  def average_score
    if self.reviews.any?
      average_score = self.reviews.map{ |x| x.score }.sum / self.reviews.count
      average_score.round(2)
    else
      return "レビューなし"
    end
  end

  # ソート機能

  # これから開始する番組を特定
  def sort_programs
    where(start_datetime: DateTime.now..Float::INFINITY)
  end

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'start_datetime'
      return where(start_datetime: DateTime.now..Float::INFINITY).order(sort_programs: :ASC)
    when 'favorite'
      return find(Favorite.group(:program_id).order(Arel.sql('count(program_id) desc')).pluck(:post_id))
    when 'review'
      return find(Review.group(:program_id).order(Arel.sql('average_score(program_id) desk')).pluck(:post_id))
    end
  end
end
