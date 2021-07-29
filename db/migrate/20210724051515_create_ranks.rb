class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.integer :program_id, null: false
      t.float :score, default: 0.0, null: false
      t.integer :favorite_sum, default: 0, null: false

      t.timestamps
    end
  end
end
