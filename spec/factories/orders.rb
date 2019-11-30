FactoryBot.define do
  factory :order do
    user_id { nil }
    total_item_price { 1 }
    discount { 1 }
    fee { 1 }
    final_price { 1 }
    method_of_payment { "MyString" }
    user_name { "MyString" }
    user_email { "MyString" }
    shipping_postal_code { 1 }
    shipping_adress { "MyString" }
    shipping_cond_n_room { "MyString" }
    user_phonenumber { 1 }
    shipping_date { "MyString" }
  end
end
