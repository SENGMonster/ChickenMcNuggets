class CreateAnswer < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :browser
      t.string :os
      t.string :ip
      t.integer :answer_possibility_id
      t.string :value

      t.timestamps
    end
  end
end
