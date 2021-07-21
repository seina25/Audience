class LineNotice < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :program, optional: true
  belongs_to :favorite, optional: true

  belongs_to :member, optional: true
  belongs_to :admin, optional: true
  
end
