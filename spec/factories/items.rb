FactoryBot.define do
  factory :item do
    name { "MyString" }
    brand_id { nil }
    description_1 { "MyText" }
    description_2 { "MyText" }
    category { "MyString" }
    price { 1 }
    wholesale_price { 1 }
    sele_price { 1 }
    public { false }
  end
end
