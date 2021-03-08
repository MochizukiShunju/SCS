class AddMakerToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :maker, :string
  end
end
