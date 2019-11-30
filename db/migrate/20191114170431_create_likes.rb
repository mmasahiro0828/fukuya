class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.string :item_color_id, null: false

      t.timestamps
    end
    add_foreign_key :likes, :item_colors
    add_index :likes, :item_color_id
  end
end
