class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :total_item_price, null: false
      t.integer :discount
      t.integer :fee
      t.integer :final_price, null: false
      t.string :method_of_payment, null: false
      t.string :user_name, null: false
      t.string :user_email, null: false
      t.integer :shipping_postal_code, null: false
      t.string :shipping_adress, null: false
      t.string :shipping_cond_n_room
      t.integer :user_phonenumber, null: false
      t.string :shipping_date, default: "指定なし"

      t.timestamps
    end
  end
end
