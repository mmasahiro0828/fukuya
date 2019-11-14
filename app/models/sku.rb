class Sku < ApplicationRecord
  belongs_to :item_id
  belongs_to :item_color_id
  belongs_to :size_id
end
