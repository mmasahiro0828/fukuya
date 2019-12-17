class Topic < ApplicationRecord
    has_many :topic_items, dependent: :destroy
        has_many :items, through: :topic_items
            has_many :item_colors, through: :items
end
