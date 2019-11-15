class TopicItem < ApplicationRecord
  belongs_to :topic
  belongs_to :item
end
