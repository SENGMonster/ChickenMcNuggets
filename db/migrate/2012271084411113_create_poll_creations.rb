class CreatePollCreations < ActiveRecord::Migration
  def change
    create_table :poll_creations do |t|
      t.integer :poll_type_id
      t.integer :category_id
      t.string :title
      t.string :question
      t.date :exp_date
      t.string :chart_type

      t.timestamps
    end
  end
end
