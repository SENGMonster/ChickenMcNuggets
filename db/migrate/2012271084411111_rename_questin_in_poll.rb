class RenameQuestinInPoll < ActiveRecord::Migration
  def self.up
    rename_column :polls, :questin, :question
  end

  def self.down
    rename_column :polls, :question, :questin
  end
end