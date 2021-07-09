class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.text :comment, null: false
      t.float :score, null: false, default: 0
      t.timestamps

      t.references :member, foreign_key: true
      t.references :program, foreign_key: true
    end
  end
end
