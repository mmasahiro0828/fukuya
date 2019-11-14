class Sale < ApplicationRecord
  belongs_to :user_id
  belongs_to :order_id
  belongs_to :sku_id
end
