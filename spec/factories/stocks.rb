FactoryBot.define do
  factory :stock do
    sku_id { nil }
    all_quantity { 1 }
    quantity_in_cart { 1 }
    quantity_on_display { 1 }
    quantity_in_by { 1 }
  end
end
