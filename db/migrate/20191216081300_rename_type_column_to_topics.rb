class RenameTypeColumnToTopics < ActiveRecord::Migration[5.2]
  def change
    rename_column :topics, :type, :category
  end
end
