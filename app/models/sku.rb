class Sku < ApplicationRecord
  belongs_to :item
  belongs_to :item_color
  belongs_to :size
  has_many: sales
  has_many: cart_items
  has_one: stock
end
