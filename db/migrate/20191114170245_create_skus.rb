class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus, id: :string do |t|
      t.references :item, foreign_key: true
      t.string :item_color_id, null: false
      t.string :size_name, null: false
      t.references :size, foreign_key: true
      t.boolean :public, default: "false"

      t.timestamps
    end
    add_foreign_key :skus, :item_colors
    add_index :skus, :item_color_id
  end
end
