class MeasuringValue < ApplicationRecord
  belongs_to :sku
  belongs_to :measuring_item
end
