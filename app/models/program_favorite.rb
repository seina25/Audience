class ProgramFavorite < ApplicationRecord
  belongs_to :member
  belongs_to :program
end
