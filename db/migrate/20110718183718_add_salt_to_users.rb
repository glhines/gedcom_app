class AddSaltToUsers < ActiveRecord::Migration[7.0]
  def self.up
    add_column :users, :salt, :string
  end

  def self.down
    remove_column :users, :salt
  end
end
