class AddCategoryidToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :category_id, :integer
  end
end
