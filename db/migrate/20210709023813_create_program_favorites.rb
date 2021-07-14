class CreateProgramFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :program_favorites do |t|

      t.timestamps

      t.references :member, foreign_key: true
      t.references :program, foreign_key: true
    end
  end
end
