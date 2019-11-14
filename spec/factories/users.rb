FactoryBot.define do
  factory :user do
    family_name { "MyString" }
    first_name { "MyString" }
    email { "MyString" }
    postal_code { 1 }
    adress { "MyString" }
    cond_n_room { "MyString" }
    phonenumber { 1 }
    password_digest { "MyString" }
    mail_magazine { false }
  end
end
