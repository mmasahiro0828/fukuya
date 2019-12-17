class ItemColor < ApplicationRecord
  belongs_to :item
  has_many :skus, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :item_images, dependent: :destroy
  belongs_to :color
end
