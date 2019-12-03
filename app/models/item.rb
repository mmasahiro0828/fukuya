class Item < ApplicationRecord
  belongs_to :brand
  has_many :item_colors
    has_many :item_images, through: :item_colors
    has_many :skus, through: :item_colors
      has_many :stocks, through: :skus
      has_many :sales, through: :skus
      has_many :cart_items, through: :skus

end
