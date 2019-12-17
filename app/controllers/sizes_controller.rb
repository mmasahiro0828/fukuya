class SizesController < ApplicationController

    def index
        @sizes = Size.all
    end



    def create_size_map
        
        default_sizes = default_size_map

        default_sizes.each do |ds|
            size = Size.new(
                id: ds[:id],
                name: ds[:name]
            )
        size.save
        end

        redirect_to sizes_url, notice: "サイズマップを作成しました。"
    end



    def destroy_all
        sizes = Size.all
        sizes.destroy_all
        redirect_to sizes_url, notice: "sizeデータをリセットしました。"
    end



    def default_size_map
        default_sizes = [
            { id: 1, name: "1" },
            { id: 2, name: "2" },
            { id: 3, name: "3" },
            { id: 4, name: "4" },
            { id: 5, name: "5" },
            { id: 6, name: "0" },
            { id: 7, name: "FREE" },
            { id: 8, name: "XS" },
            { id: 9, name: "S" },
            { id: 10, name: "M" },
            { id: 11, name: "L" },
            { id: 12, name: "XL" },
            { id: 13, name: "25" },
            { id: 14, name: "25.5" },
            { id: 15, name: "26" },
            { id: 16, name: "26.5" },
            { id: 17, name: "27" },
            { id: 18, name: "27.5" },
            { id: 19, name: "28" },
            { id: 20, name: "28.5" },
            { id: 21, name: "29" },
            { id: 22, name: "29.5" },
            { id: 23, name: "30" }
        ]

        return default_sizes   
    end


end
