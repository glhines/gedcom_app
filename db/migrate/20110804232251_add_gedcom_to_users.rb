class AddGedcomToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gedcom_file_name, :string
    add_column :users, :gedcom_content_type, :string
    add_column :users, :gedcom_file_size, :integer
    add_column :users, :gedcom_updated_at, :datetime
  end
end
