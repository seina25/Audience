class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_programs, through: :favorites, source: :program
  has_many :program_notifications, dependent: :destroy

  validates :last_name, presence: true, length: { in: 1..10 }
  validates :first_name, presence: true, length: { in: 1..10 }
  validates :kana_sei, presence: true, length: { in: 1..10 }, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :kana_mei, presence: true, length: { in: 1..10 }, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :nickname, presence: true, length: { in: 1..15 }
  validates :gender, presence: true
  validates :prefecture, presence: true


  enum gender: { man: 0, woman: 1, other: 2 }

  # ユーザの退会フラグ：is_validが有効であればtrueを返す
  enum is_valid: { '有効': true, '退会済': false }
  def active_for_authentication?
    super && self.is_valid == '有効'
  end

  attachment :profile_image

  # 引数(通知対象)の番組を'お気に入り'したことがある
  scope :has_favprogram_id, -> program_id {
    joins(:program).merge(Program.id_is program_id)
  }
end
