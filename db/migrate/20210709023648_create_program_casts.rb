class CreateProgramCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :program_casts do |t|

      t.timestamps
    end
  end
end
