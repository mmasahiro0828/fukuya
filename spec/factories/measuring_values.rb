FactoryBot.define do
  factory :measuring_value do
    sku_id { nil }
    measuring_item_id { nil }
    measuring_item_name { "MyString" }
    value { 1.5 }
  end
end
