class Item < ApplicationRecord
  belongs_to :brand
  has_many :item_colors, dependent: :destroy

    has_many :item_images, through: :item_colors
    has_many :colors, through: :item_colors
    has_many :skus, through: :item_colors
    
      has_many :stocks, through: :skus
      has_many :measuring_values, through: :skus
        has_many :measuring_items, through: :measuring_values
      has_many :sales, through: :skus
      has_many :cart_items, through: :skus

  has_many :topic_items
    has_many :topics, through: :topic_items
    
end
