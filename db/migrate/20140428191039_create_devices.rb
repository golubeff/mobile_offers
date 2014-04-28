class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uuid, :null => false
      t.string :os
      t.string :model
      t.string :ifa
      t.string :mac
      t.integer :user_id
      t.string :token
    end

    add_index :devices, :token, :unique => true
    add_foreign_key :devices, :users
  end
end
