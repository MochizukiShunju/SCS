class RenameGroupColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :group, :department
  end
end
