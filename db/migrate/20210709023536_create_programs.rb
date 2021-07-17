class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|

      t.string :title, null: false
      t.string :second_title, null
      t.text :description, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :by_weekday, null: false, default: 0
      t.time :by_time, null: false, default: 0
      t.string :program_image_id, null: false
      t.integer :status, null: false
      t.string :goods, null: false
      t.timestamps
    end

      add_index :programs, [:by_weekday, :by_time]
  end
end
