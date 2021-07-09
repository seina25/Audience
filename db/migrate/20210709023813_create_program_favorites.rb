class CreateProgramFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :program_favorites do |t|

      t.timestamps
    end
  end
end
