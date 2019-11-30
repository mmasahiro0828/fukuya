class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :user, foreign_key: true
      t.string :sku_id, null: false
      t.integer :quantity, null: false
      t.integer :total_item_price
      t.integer :discount
      t.integer :price_w_tax

      t.timestamps
    end
    add_foreign_key :cart_items, :skus
    add_index :cart_items, :sku_id
  end
end
