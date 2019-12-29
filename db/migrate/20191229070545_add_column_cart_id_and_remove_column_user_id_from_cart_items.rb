class AddColumnCartIdAndRemoveColumnUserIdFromCartItems < ActiveRecord::Migration[5.2]
  def up
    add_reference :cart_items, :cart, foreign_key: true
    remove_column :cart_items, :user_id
  end

  def down
    remove_column :cart_items, :cart_id
    add_reference :cart_items, :user, foireign_key: true
  end
end
