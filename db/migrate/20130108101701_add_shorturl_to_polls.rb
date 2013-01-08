class AddShorturlToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :shorturl, :string
  end
end
