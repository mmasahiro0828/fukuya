class AddColorIdToItemColors < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_colors, :color, foreign_key: true
  end
end
