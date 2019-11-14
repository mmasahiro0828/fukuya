class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :email, null: false
      t.integer :postal_code
      t.string :adress
      t.string :cond_n_room
      t.integer :phonenumber, null: false
      t.string :password_digest, null: false
      t.boolean :mail_magazine, default: "true"

      t.timestamps
    end
  end
end
