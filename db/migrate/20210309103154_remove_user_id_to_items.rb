class RemoveUserIdToItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :user_id
  end
end
