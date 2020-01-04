class CartItem < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :cart
  belongs_to :sku
end
