class CreateTopicItems < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_items do |t|
      t.references :topic, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
