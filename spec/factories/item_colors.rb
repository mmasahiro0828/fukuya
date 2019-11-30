FactoryBot.define do
  factory :item_color do
    item_id { nil }
    color_name { "MyString" }
    color_code { "MyString" }
    public { false }
  end
end
