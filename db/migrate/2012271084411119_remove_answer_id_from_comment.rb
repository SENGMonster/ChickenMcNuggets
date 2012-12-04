class RemoveAnswerIdFromComment < ActiveRecord::Migration
  def up
    remove_column :comments, :answer_id
      end

  def down
    add_column :comments, :answer_id, :integer
  end
end
