class ItemsController < ApplicationController

    def show
        @brands = Brand.all
        @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])

        @item = Item.find(params[:id])
        @item_colors = @item.item_colors
        @item_color = @item.item_colors.find_by(color_name: params[:color_name])
        @skus = @item_color.skus.order(:created_at)


        @measuring_items = @skus.first.measuring_items.order(:id)
        @measuring_values = @item.measuring_values

        @related_topics = @item.topics

        @same_brand_items = Item.where(brand_id: @item.brand_id).where.not(id: @item.id).limit(8)

        @same_category_items =Item.where(category: @item.category).where.not(id: @item.id).limit(8)
    end

    
    def index
        @brands = Brand.all
        @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])
        
        @group_title = params[:searched_by]

        if params[:searched_by] == "ALL"
            @group_items = Item.all
        else 
            @group_items = Item.where(category: params[:searched_by])
        end
        
    end


end

