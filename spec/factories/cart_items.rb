FactoryBot.define do
  factory :cart_item do
    user_id { nil }
    sku_code { nil }
    quantity { 1 }
    total_item_price { 1 }
    discount { 1 }
    price_w_tax { 1 }
  end
end
