class HomeController < ApplicationController
  def top
    @brands = Brand.all
    @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])

    @pickup_items = Topic.find_by(category: "PICK UP").items
    
    @new_arrival_items = Topic.find_by(category: "NEW ARRIVALS").items
    
  end

  
end
