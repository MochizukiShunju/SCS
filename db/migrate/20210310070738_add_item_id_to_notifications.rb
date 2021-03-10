class AddItemIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :item_id, :integer
    add_index :notifications, :item_id
  end

end
