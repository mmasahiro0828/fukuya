class Admin::ItemColorsController < ApplicationController

    before_action :color_map_exist?, only: [:register_color_to_each_sample_item]

    def color_map_exist?
        if Color.count < 10
            redirect_to admin_root_url, notice: "カラーを登録してください。"
        end
    end



    def register_colors_to_each_sample_item
        items_without_colors = Item.where(number_of_colors: 0)
        
        items_without_colors.each do |item|
            
            number_of_set_colors = rand(1..5)
            set_colors = Color.all.sample(number_of_set_colors).sort_by(&:id)

            set_colors.each do |color|
                item_color = ItemColor.new(
                    id: "#{item.id}-#{color.code}",
                    item_id: item.id,
                    color_name: color.name,
                    color_id: color.id,
                    public: "false"
                )

                item_color.save
            end

            item.update(number_of_colors: number_of_set_colors)
        end

        redirect_to admin_items_url, notice: "各アイテムにカラーを登録しました。"
    end



    def destroy_all

        items = Item.all
        items.each do |i|
            i.update(number_of_colors: 0)
            i.update(number_of_sizes: 0)
        end

        item_colors = ItemColor.all
        item_colors.destroy_all

        redirect_to admin_items_url, notice: "item_colorsデータをリセットしました。"
    end

end
