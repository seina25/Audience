class Review < ApplicationRecord
  belongs_to :member
  belongs_to :program
  
  # has_many :rank

  validates :comment, presence: true
  validates :score, presence: true
end
