class Brand < ApplicationRecord
    has_many :brand_representatives
    has_many :items
end
