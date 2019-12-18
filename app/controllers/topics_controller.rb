class TopicsController < ApplicationController

    def show
        @brands = Brand.all
        @topics = Topic.where.not(category:["PICK UP", "NEW ARRIVALS"])

        @topic = Topic.find(params[:id])

        @group_title = @topic.name
        @group_items = @topic.items
    end

end
