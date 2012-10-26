class CreateAnswerPossibility < ActiveRecord::Migration
  def change
    create_table :answer_possibilities do |t|
      t.string :value
      t.integer :poll_id

      t.timestamps
    end
  end
end
