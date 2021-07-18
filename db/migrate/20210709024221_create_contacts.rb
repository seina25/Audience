class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|

      t.string :title, null: false
      t.text :message, null: false
      t.timestamps

      t.references :member, type: :bigint, foreign_key: true
    end
  end
end
