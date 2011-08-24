class CreateGedcoms < ActiveRecord::Migration
  def change
    create_table :gedcoms do |t|
      t.string :gedcom_file_name
      t.integer :gedcom_file_size
      t.string :gedcom_content_type
      t.datetime :gedcom_updated_at
      t.integer :user_id

      t.timestamps
    end

    add_index :gedcoms, :user_id
  end
end
