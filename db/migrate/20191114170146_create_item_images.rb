class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.references :item, foreign_key: true
      t.string :item_color_id, null: false
      t.string :image_name, default: "no_image.jpg"

      t.timestamps
    end
    add_foreign_key :item_images, :item_colors
    add_index :item_images, :item_color_id
  end
end
