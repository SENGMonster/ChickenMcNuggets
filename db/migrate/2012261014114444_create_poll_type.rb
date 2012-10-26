class CreatePollType < ActiveRecord::Migration
  def change
    create_table :poll_types do |t|
      t.string :name
  
      t.timestamps
    end
  end
end
