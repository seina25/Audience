class Program < ApplicationRecord
  extend OrderAsSpecified

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

  # 検索機能
  # binding.pry
  scope :search, lambda { |program_search_params|
    if program_search_params.blank? || (program_search_params[:keyword].blank? && program_search_params[:start_datetime_from].blank? && program_search_params[:start_datetime_to].blank?)
      return
    end

    keyword_like(program_search_params[:keyword]).start_datetime_between(program_search_params[:start_datetime_from], program_search_params[:start_datetime_to])
  }
  # キーワード検索
  scope :keyword_like, lambda { |search|
                         if search.present?
                           where(['title LIKE ? OR channel LIKE ? OR category LIKE ? OR talent LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
                         end
                       }
  # 放送時間範囲検索
  scope :start_datetime_between, lambda { |from, to|
    if from.present? && to.present?
      where(start_datetime: from..to)
    elsif from.present?
      where('start_datetime >= ?', from)
    elsif to.present?
      where('start_datetime <= ?', to)
    end
  }

  # 評価機能
  # 評価の平均値
  def average_score
    if reviews.any?
      average_score = reviews.map { |x| x.score }.sum / reviews.count
      average_score.round(2)
    else
      'レビューなし'
    end
  end

  # ソート機能

  def self.sort(selection)
    case selection
    when 'start_datetime'
      where(start_datetime: DateTime.now..Float::INFINITY).order(start_datetime: :ASC)
    when 'new'
      all.order(created_at: :DESC)
    when 'favorite'
      ids = find(Favorite.group(:program_id).order(Arel.sql('count(program_id) desc')).pluck(:program_id)).pluck(:id)
      Program.order_as_specified(id: ids)
    when 'review'
      ids = find(Review.group(:score).order('avg(score) desc').pluck(:program_id)).pluck(:id)
      if ids.empty?
        all.order(created_at: :DESC)
      else
        Program.order_as_specified(id: ids)
      end
    when 'view'
      ids = find(ViewCount.group(:program_id).order(Arel.sql('count(program_id) desc')).pluck(:program_id)).pluck(:id)
      Program.order_as_specified(id: ids)
    else
      where(start_datetime: DateTime.now..Float::INFINITY).order(start_datetime: :ASC)
    end
  end

  def self.program_selected_sort(selection)
    sort = if selection == 'new'
             %w[新着順 new]
           elsif selection == 'favorite'
             %w[お気に入り順 favorite]
           elsif selection == 'review'
             %w[評価が高い順 review]
           elsif selection == 'view'
             %w[PV数 view]
           else
             %w[これからの放送順 start_datetime]
           end
  end
end
