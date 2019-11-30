class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :sku
end
