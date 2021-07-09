class CreateProgramCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :program_casts do |t|

      t.timestamps
      
      t.references :program, foreign_key: true
      t.references :cast, foreign_key: true
    end
  end
end
