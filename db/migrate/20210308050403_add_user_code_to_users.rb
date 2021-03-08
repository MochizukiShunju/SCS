class AddUserCodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_code, :integer
  end
end
