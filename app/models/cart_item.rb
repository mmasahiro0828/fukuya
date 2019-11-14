class CartItem < ApplicationRecord
  belongs_to :user_id
  belongs_to :sku_code
end
