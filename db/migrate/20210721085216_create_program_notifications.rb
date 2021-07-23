class CreateProgramNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :program_notifications do |t|
      t.integer :member_id, null: false
      t.integer :program_id, null: false
      t.integer :favorite_id, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :program_notifications, :member_id
    add_index :program_notifications, :program_id
    add_index :program_notifications, :favorite_id
  end
end
