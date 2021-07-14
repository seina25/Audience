class CreateCastFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :cast_favorites do |t|

      t.timestamps

      t.references :member, type: :bigint, foreign_key: true
      t.references :cast, type: :bigint, foreign_key: true
    end
  end
end
