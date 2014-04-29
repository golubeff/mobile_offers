class AddUniqueIndexToDevices < ActiveRecord::Migration
  def change
    Device.destroy_all
    User.destroy_all
    add_index :devices, [ :uuid, :os, :model, :ifa, :mac, :user_id ], :unique => true, :name => :unique_device
  end
end
