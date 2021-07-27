class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :reviews, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_programs, through: :favorites, source: :program
  has_many :view_counts, dependent: :destroy

  validates :last_name, presence: true, length: { in: 1..10 }
  validates :first_name, presence: true, length: { in: 1..10 }
  validates :kana_sei, presence: true, length: { in: 1..10 }, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :kana_mei, presence: true, length: { in: 1..10 }, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :nickname, presence: true, length: { in: 1..15 }
  validates :gender, presence: true
  validates :prefecture, presence: true

  enum gender: { man: 0, woman: 1, other: 2 }
  
  def full_name
    [first_name, last_name].join(' ')
  end


  # 放送前の通知時間の設定
  def today_favorite_programs
    fav_programs.where(start_datetime: from..to(notification_time))
  end

  # 通知マークの表示切り替え
  def favorite_checked_update
    favorites.includes([:program]).each do |favorite|
      favorite.update(checked: true)
    end
  end
  
  def new_notificatioin_exsist?
    fav_programs.includes(:favorites).where(start_datetime: from..to(notification_time)).where(favorites: {checked: false}).any?
  end
  



  # ユーザの退会フラグ：is_validが有効であればtrueを返す
  enum is_valid: { '有効': true, '退会済': false }
  def active_for_authentication?
    super && self.is_valid == '有効'
  end

  attachment :profile_image
  
  
  private
  

  def from
    DateTime.now
  end
  
  def to(notification_time)
     DateTime.now + Rational(notification_time,24)
  end
  

end
