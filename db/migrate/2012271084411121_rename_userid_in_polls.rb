class RenameUseridInPolls < ActiveRecord::Migration
  def up
    rename_column :polls, :user_id, :creator_id
  end

  def down
    rename_column :polls, :creator_id, :user_id
  end
end
