class ChangeDataProgramIdToProgramCast < ActiveRecord::Migration[5.2]

  def change
    remove_foreign_key :program_casts, :programs
    remove_reference :program_casts, :program, index: true
    add_reference :program_casts, :program, type: :bignt, foreign_key: true
  end
end