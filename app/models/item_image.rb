class ItemImage < ApplicationRecord
  belongs_to :item
  belongs_to :item_color
end
