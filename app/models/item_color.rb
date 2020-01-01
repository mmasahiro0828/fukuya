class ItemColor < ApplicationRecord
  belongs_to :item
  belongs_to :color

  has_many :skus, dependent: :destroy
    has_many :stocks, through: :skus
    has_many :measuring_values, through: :skus
      has_many :measuring_items, through: :measuring_values
    has_many :sales, through: :skus
    has_many :cart_items, through: :skus

  has_many :likes, dependent: :destroy
    has_many :users, through: :likes
  has_many :item_images, dependent: :destroy
end
