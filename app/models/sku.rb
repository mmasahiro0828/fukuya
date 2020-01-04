class Sku < ApplicationRecord
  belongs_to :item
  belongs_to :item_color
  belongs_to :size

  has_many :sales, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :measuring_values, dependent: :destroy
    has_many :measuring_items, through: :measuring_values
  has_one :stock, dependent: :destroy

end
