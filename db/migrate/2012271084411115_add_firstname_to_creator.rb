class AddFirstnameToCreator < ActiveRecord::Migration
  def change
    add_column :creators, :firstname, :string
    add_column :creators, :lastname, :string
  end
end
