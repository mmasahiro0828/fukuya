class ItemColor < ApplicationRecord
  belongs_to :item
  has_many :skus
  has_many :likes
  has_many :item_images
  belongs_to :colors
end
