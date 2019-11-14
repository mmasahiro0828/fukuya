class TopicItem < ApplicationRecord
  belongs_to :topic_id
  belongs_to :item_id
end
