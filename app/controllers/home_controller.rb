class HomeController < ApplicationController
  def top
    @brands = Brand.all
    @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])

    pickup_items = Topic.find_by(category: "PICK UP").topic_items
    item_ids = []
    pickup_items.each do |pi|
      item_ids.push(pi.item_id)
    end
    @pickup_items = Item.where(id: item_ids)

    new_arrival_items = Topic.find_by(category: "NEW ARRIVALS").topic_items
    item_ids_2 = []
    new_arrival_items.each do |nai|
      item_ids_2.push(nai.item_id)
    end
    @new_arrival_items = Item.where(id: item_ids_2)
    
  end

  
end
