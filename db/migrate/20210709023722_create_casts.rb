class CreateCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :casts do |t|
      t.string :name, null: false
      t.string :affiliation
      t.string :occupation, null: false
      t.string :cast_image_id, null: false
      t.timestamps
    end
    add_index :casts, [:name, :affiliation, :occupation]
  end
end
