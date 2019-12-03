class User < ApplicationRecord
    has_many :cart_items
    has_many :sales
    has_many :orders
end
