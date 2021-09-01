class Review < ApplicationRecord
  belongs_to :member
  belongs_to :program


  validates :comment, presence: true
  validates :score, presence: true
end
