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
  scope :search, -> (program_search_params) do
    return if program_search_params.blank?
    keyword_like(program_search_params[:keyword]).start_datetime_between(program_search_params[:start_datetime_from], program_search_params[:start_datetime_to])
  end

  # キーワード検索
  scope :keyword_like, -> keyword { where(['title LIKE ? OR channel LIKE ? OR category LIKE ? OR talent LIKE ?',"%#{search}%","%#{search}%","%#{search}%","%#{search}%"]) if keyword.present? }
  # 放送時間範囲検索
  scope :start_datetime_between, -> from, to {
    from = DateTime.now
    to = DateTime.now + 10
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
    when 'start_datetime'
      where(start_datetime: DateTime.now..Float::INFINITY).order(sort_programs: :ASC)
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
      where(start_datetime: DateTime.now..Float::INFINITY).order(sort_programs: :ASC)
    end
  end

  def self.program_selected_sort(selection)
    if selection == 'new'
      sort = ['新着順', 'new']
    elsif selection == 'favorite'
      sort = ['お気に入り順', 'favorite']
    elsif selection == 'review'
      sort = ['評価が高い順', 'review']
    elsif selection == 'view'
      sort = ['PV数', 'view']
    else
      sort = ['これからの放送順', 'start_datetime']
    end
  end

end
