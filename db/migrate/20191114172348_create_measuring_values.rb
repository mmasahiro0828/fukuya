class CreateMeasuringValues < ActiveRecord::Migration[5.2]
  def change
    create_table :measuring_values do |t|
      t.string :sku_id, null: false
      t.references :measuring_item, foreign_key: true
      t.string :measuring_item_name, null: false
      t.float :value, default: "-"

      t.timestamps
    end
    add_foreign_key :measuring_values, :skus
    add_index :measuring_values, :sku_id
  end
end
