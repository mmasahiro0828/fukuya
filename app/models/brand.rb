class Brand < ApplicationRecord
    has_many :brand_representatives, dependent: :destroy
    has_many :items, dependent: :destroy
        has_many :item_colors, through: :items

    validates :name, presence: true
    validates :kana_name, presence: true
end
