class ChangeDataPostalCodeAndPhonenumberToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :postal_code, :string
    change_column :users, :phonenumber, :string
  end
end
