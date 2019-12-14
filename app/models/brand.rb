class Brand < ApplicationRecord
    has_many :brand_representatives, dependent: :destroy
    has_many :items, dependent: :destroy
end
