class CreateBrandRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_representatives do |t|
      t.references :brand, foreign_key: true
      t.string :name, null: false
      t.string :email
      t.integer :phonenumber

      t.timestamps
    end
  end
end
