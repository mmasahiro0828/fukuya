class Admin::ColorsController < ApplicationController

    def index
        @colors = Color.all
    end

    


    def create_color_map
        
        default_colors = default_color_map

        default_colors.each do |dc|
            color = Color.new(
            id: dc[:id],
            name: dc[:name],
            code: dc[:code]
            )

            color.save
        end

        redirect_to admin_colors_url, notice: "カラーマップを作成しました。"
    end


    def destroy_all
        colors = Color.all
        colors.destroy_all
        redirect_to admin_colors_url, notice: "colorデータをリセットしました。"
    end

    
    def default_color_map
        default_colors = [
            {id: 1, name: "WHITE", code: "WHT"},
            {id: 2, name: "OFF WHITE", code: "OWHT"},
            {id: 3, name: "IVORY", code: "IVY"},
            {id: 4, name: "YELLOW", code: "YLW"},
            {id: 5, name: "ORANGE", code: "ORG"},
            {id: 6, name: "GREEN", code: "GRN"},
            {id: 7, name: "LIGHT GREEN", code: "LGRN"},
            {id: 8, name: "DARK GREEN", code: "DGRN"},
            {id: 9, name: "RED", code: "RED"},
            {id: 10, name: "PINK", code: "PNK"},
            {id: 11, name: "BURGUNDY", code: "BRG"},
            {id: 12, name: "BULE", code: "BLU"},
            {id: 13, name: "SKY BLUE", code: "SBLU"},
            {id: 14, name: "NAVY", code: "NVY"},
            {id: 15, name: "BROWN", code: "BRN"},
            {id: 16, name: "BEIGE", code: "BGE"},
            {id: 17, name: "DARK BROWN", code: "DBRN"},
            {id: 18, name: "PULPLE", code: "PPL"},
            {id: 19, name: "GRAY", code: "GRY"},
            {id: 20, name: "LIGHT GRAY", code: "LGRY"},
            {id: 21, name: "DARK GRAY", code: "DGRY"},
            {id: 22, name: "BLACK", code: "BLK"},
            {id: 23, name: "MULTI", code: "MLT"},
            {id: 24, name: "OTHER01", code: "OT1"},
            {id: 25, name: "OTHER02", code: "OT2"},
            {id: 26, name: "OTHER03", code: "OT3"},
            {id: 27, name: "OTHER04", code: "OT4"},
            {id: 28, name: "OTHER05", code: "OT5"},
            {id: 29, name: "OTHER06", code: "OT6"}
        ]

        return default_colors
        
    end
end
