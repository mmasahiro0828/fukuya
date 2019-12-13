class RenameSelePriceColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :sele_price, :sale_price
  end
end
