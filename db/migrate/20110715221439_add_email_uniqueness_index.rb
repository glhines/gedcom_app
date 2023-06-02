class AddEmailUniquenessIndex < ActiveRecord::Migration[7.0]
  def self.up
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
