class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name, default: "未定"
      t.string :type, null: false
      t.string :description
      t.string :sum_image_name, default: "no_image.jpg"
      t.string :main_image_name, default: "no_image.jpg"
      t.boolean :public, default: "false"

      t.timestamps
    end
  end
end
