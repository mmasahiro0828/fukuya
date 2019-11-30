FactoryBot.define do
  factory :sku do
    item_id { nil }
    item_color_id { nil }
    size_name { "MyString" }
    size_id { nil }
    public { false }
  end
end
