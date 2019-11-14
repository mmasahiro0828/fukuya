FactoryBot.define do
  factory :sale do
    user_id { nil }
    order_id { nil }
    sku_id { nil }
    quantity { 1 }
    total_item_price { 1 }
    discount { 1 }
    price_w_tax { 1 }
  end
end
