class CreateItemColors < ActiveRecord::Migration[5.2]
  def change
    create_table :item_colors, id: :string do |t|
      t.references :item, foreign_key: true
      t.string :color_name, null: false
      t.string :color_code, null: false
      t.boolean :public, default: "false"

      t.timestamps
    end
  end
end
