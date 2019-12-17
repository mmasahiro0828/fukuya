class Admin::StocksController < ApplicationController

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
    
end
