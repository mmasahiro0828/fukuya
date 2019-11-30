class CreateMeasuringItems < ActiveRecord::Migration[5.2]
  def change
    create_table :measuring_items do |t|
      t.string :name, null: false
      t.boolean :default, default: "false"

      t.timestamps
    end
  end
end
