class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name, null: false
      t.string :kana_name, null: false
      t.text :description
      t.string :image_name, default: "no_image.jpg"
      t.integer :rate_of_retail_price
      t.string :website
      t.boolean :public, default: "false"

      t.timestamps
    end
  end
end
