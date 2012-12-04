class AddGuidToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :guid, :string
  end
end
