class CreateLineNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :line_notices do |t|
      t.integer :member_id, null: false
      t.integer :admin_id, null: false
      t.integer :program_id, null: false
      t.integer :favorite_id, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :line_notices, :member_id
    add_index :line_notices, :admin_id
    add_index :line_notices, :program_id
    add_index :line_notices, :favorite_id
  end
end
