class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :sku_id, null: false
      t.integer :all_quantity, default: 0
      t.integer :quantity_in_cart, default: 0
      t.integer :quantity_on_display, null: false
      t.integer :quantity_in_by, null: false

      t.timestamps
    end
    add_foreign_key :stocks, :skus
    add_index :stocks, :sku_id
  end
end
