class CreateViewCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :view_counts do |t|
      t.integer :member_id
      t.integer :program_id
      t.timestamps
    end
  end
end
