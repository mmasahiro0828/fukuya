class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.string :sku_id, null: false
      t.integer :quantity
      t.integer :total_item_price
      t.integer :discount, default: 0
      t.integer :price_w_tax

      t.timestamps
    end
    add_foreign_key :sales, :skus
    add_index :sales, :sku_id
  end
end
