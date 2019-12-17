class ItemsController < ApplicationController

    def show
        @brands = Brand.all
        @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])

        @item = Item.find(params[:id])
        @colors = @item.item_colors
        @item_color = @item.item_colors.find_by(color_name: params[:color_name])
        @skus = @item_color.skus.order(:created_at)

        @measuring_item_names = []
        @skus.first.measuring_values.order(:id).each do |mv|
            @measuring_item_names.push(mv.measuring_item_name)
        end

        related_topic_items = TopicItem.where(item_id: @item.id)
        related_topic_ids =[]
        related_topic_items.each do |rti|
            related_topic_ids.push(rti.topic_id)
        end
        @related_topics = Topic.where(id: related_topic_ids)

        @same_brand_items = Item.where(brand_id: @item.brand_id).where.not(id: @item.id).limit(8)

        @same_category_items =Item.where(category: @item.category).where.not(id: @item.id).limit(8)

    end


end

