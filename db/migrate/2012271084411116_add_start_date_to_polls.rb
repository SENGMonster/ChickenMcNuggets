class AddStartDateToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :start_date, :date
  end
end
