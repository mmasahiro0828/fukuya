class Admin::StocksController < ApplicationController

    before_action :admin_user_required

    def index
        @skus = Sku.all.order(:created_at)
    end

    def update
        stock = Stock.find(params[:id])
        stock.update(
            all_quantity: stock.all_quantity + params[:add_num].to_i,
            quantity_on_display: stock.quantity_on_display + params[:add_num].to_i
        )
        
        redirect_to admin_stocks_url
    end

    def plus_1_to_by
        stock = Stock.find(params[:stock_id])
        stock.update(
            all_quantity: stock.all_quantity + 1,
            quantity_in_by: stock.quantity_in_by + 1
        )
        @item_colors = stock.sku.item.item_colors
    end

    def minus_1_from_by
        stock = Stock.find(params[:stock_id])
        stock.update(
            all_quantity: stock.all_quantity - 1,
            quantity_in_by: stock.quantity_in_by - 1
        )
        @item_colors = stock.sku.item.item_colors
    end

    def move_1_to_display
        stock = Stock.find(params[:stock_id])
        stock.update(
            quantity_in_by: stock.quantity_in_by - 1,
            quantity_on_display: stock.quantity_on_display + 1
        )
        @item_colors = stock.sku.item.item_colors
    end

    def move_1_to_by
        stock = Stock.find(params[:stock_id])
        stock.update(
            quantity_in_by: stock.quantity_in_by + 1,
            quantity_on_display: stock.quantity_on_display - 1
        )
        @item_colors = stock.sku.item.item_colors
    end
    
end
