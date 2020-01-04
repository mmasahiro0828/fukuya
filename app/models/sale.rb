class Sale < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order
  belongs_to :sku
end
