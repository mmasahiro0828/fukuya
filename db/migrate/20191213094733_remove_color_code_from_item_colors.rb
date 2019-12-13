class RemoveColorCodeFromItemColors < ActiveRecord::Migration[5.2]
  def change
    remove_column :item_colors, :color_code, :string
  end
end
