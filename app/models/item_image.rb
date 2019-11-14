class ItemImage < ApplicationRecord
  belongs_to :item_id
  belongs_to :item_color_id
end
