class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :program
  validates_uniqueness_of :program_id, scope: :member_id

  has_many :line_notices, dependent: :destroy
end
