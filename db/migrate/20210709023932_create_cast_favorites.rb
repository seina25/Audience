class CreateCastFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :cast_favorites do |t|

      t.timestamps
    end
  end
end
