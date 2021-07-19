class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|

      t.timestamps

      t.references :member, type: :bigint, foreign_key: true
      t.references :program, type: :bigint, foreign_key: true
    end
  end
end
