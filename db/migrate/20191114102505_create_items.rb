class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, default: "未定"
      t.references :brand, foreign_key: true
      t.text :description_1
      t.text :description_2
      t.string :category, null: false
      t.integer :price, null: false
      t.integer :wholesale_price
      t.integer :sele_price
      t.boolean :public, default: "false"

      t.timestamps
    end
  end
end
