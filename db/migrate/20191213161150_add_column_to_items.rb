class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :number_of_colors, :integer, default: 0
    add_column :items, :number_of_sizes, :integer, default: 0
  end
end
