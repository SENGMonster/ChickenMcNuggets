class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.string :questin
      t.date :exp_date
      t.integer :user_id
      t.integer :poll_type_id

      t.timestamps
    end
  end
end
