FactoryBot.define do
  factory :brand do
    name { "MyString" }
    kana_name { "MyString" }
    description { "MyText" }
    image_name { "MyString" }
    rate_of_retail_price { 1 }
    website { "MyString" }
    public { false }
  end
end
