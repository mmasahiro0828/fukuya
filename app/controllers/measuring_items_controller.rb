class MeasuringItemsController < ApplicationController

    def index
        @measuring_items = MeasuringItem.all
    end

    def create_measuring_items_map
        
        default_measuring_items = default_measuring_items_map

        default_measuring_items.each do |dmi|
            measuring_item = MeasuringItem.new(
                id: dmi[:id],
                name: dmi[:name],
                default: "true"
            )
            measuring_item.save
        end

        redirect_to measuring_items_url, notice: "採寸項目マップを作成しました。"
    end



    def destroy_all
        measuring_items = MeasuringItem.all
        measuring_items.destroy_all
        redirect_to measuring_items_url, notice: "採寸項目データをリセットしました。"
    end



    def default_measuring_items_map
        default_measuring_items = [
            { id: 1, name: "着丈" },
            { id: 2, name: "肩幅" },
            { id: 3, name: "身幅" },
            { id: 4, name: "袖丈" },
            { id: 5, name: "ウエスト" },
            { id: 6, name: "股上" },
            { id: 7, name: "股下" },
            { id: 8, name: "腿幅" },
            { id: 9, name: "裾幅" }
        ]

        return default_measuring_items   
    end

end
