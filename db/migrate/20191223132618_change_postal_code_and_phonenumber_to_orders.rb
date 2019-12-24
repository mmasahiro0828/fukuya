class ChangePostalCodeAndPhonenumberToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :shipping_postal_code, :string
    change_column :orders, :user_phonenumber, :string
  end
end
