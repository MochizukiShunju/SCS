class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :model
      t.integer :amount
      t.integer :price
      t.string :retailer
      t.string :status

      t.timestamps
    end
  end
end
