class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :program_favorites, dependent: :destroy
  has_many :cast_favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :contacts, dependent: :destroy

  validates :last_name, presence: true, length: { in: 1..10 }
  validates :first_name, presence: true, length: { in: 1..10 }
  validates :kana_sei, presence: true, length: { in: 1..10 }, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :kana_mei, presence: true, length: { in: 1..10 }, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :nickname, presence: true, length: { in: 1..15 }
  validates :gender, presence: true
  validates :prefecture, presence: true
  validates :line_id, uniqueness: true
  # validates :deleted_at, presence: true

  enum gender: { man: 0, woman: 1, other: 2 }
  attachment :profile_image_id
end
