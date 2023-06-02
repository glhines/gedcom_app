class CreateMicroposts < ActiveRecord::Migration[7.0]
  def self.up
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :microposts
  end
end
