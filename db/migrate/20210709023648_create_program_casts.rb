class CreateProgramCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :program_casts do |t|

      t.timestamps

      t.references :program , type: :bigint, foreign_key: true
      t.references :cast, type: :bigint, foreign_key: true
    end
  end
end
