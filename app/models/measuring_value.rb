class MeasuringValue < ApplicationRecord
  belongs_to :sku_id
  belongs_to :measuring_item_id
end
