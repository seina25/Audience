class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|

      t.string :title, null: false
      t.string :second_title, null: false
      t.string :category, null: false
      t.string :cast
      t.string :channel, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.integer :by_weekday, null: false, default: 0
      t.string :program_image_id
      t.integer :status, null: false, default: 0
      t.timestamps
    end

      add_index :programs, [:channel, :start_datetime], unique: true
  end
end
