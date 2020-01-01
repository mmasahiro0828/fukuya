class LikesController < ApplicationController

    def create
        @item = Item.find(params[:id])
        @item_color = @item.item_colors.find_by(color_name: params[:color_name])

        like = current_user.likes.new(
            item_color_id: @item_color.id
        )
        like.save

        redirect_to item_path(id: @item.id, color_name: @item_color.color_name)
    end


    def destroy
        @item = Item.find(params[:id])
        @item_color = @item.item_colors.find_by(color_name: params[:color_name])

        like = current_user.likes.find_by(
            item_color_id: @item_color.id
        )

        like.destroy

        redirect_to item_path(id: @item.id, color_name: @item_color.color_name)
    end

    def index
        @brands = Brand.all
        @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])
        
        @item_colors = current_user.item_colors
    end
end
