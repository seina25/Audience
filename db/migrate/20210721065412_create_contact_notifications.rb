class CreateContactNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_notifications do |t|
      t.integer :contact_id
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
