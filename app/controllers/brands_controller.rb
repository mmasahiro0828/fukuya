class BrandsController < ApplicationController

    def show
        @brands = Brand.all
        @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])

        @brand = Brand.find(params[:id])

        @group_title = @brand.name
        @group_items = @brand.items
    end

end

