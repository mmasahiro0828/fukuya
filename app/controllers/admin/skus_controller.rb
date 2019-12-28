class Admin::SkusController < ApplicationController

    def register_sizes_to_each_sample_item
        items_without_sizes = Item.where(number_of_sizes: 0).order(:id)
        
        items_without_sizes.each do |item|

            case item.category
            when "アウター", "トップス"
                register_sizes_id = (9..12)
                register_size_details = [
                    { mi_id: 1, mv: 60},
                    { mi_id: 2, mv: 44},
                    { mi_id: 3, mv: 48},
                    { mi_id: 4, mv: 58}
                ]
            when "ボトムス"
                register_sizes_id = (9..10)
                register_size_details = [
                    { mi_id: 5, mv: 74},
                    { mi_id: 6, mv: 36},
                    { mi_id: 7, mv: 60},
                    { mi_id: 8, mv: 36},
                    { mi_id: 9, mv: 22}
                ]
            when "シューズ"
                register_sizes_id = (14..21)
                register_size_details = nil
            else
                register_sizes_id = 7
                register_size_details = nil
            end

            register_sizes = Size.where(id: register_sizes_id).order(:id)

            item.item_colors.each do |i_c|
                register_sizes.each_with_index do |size, index|
                    sku = Sku.new(
                        id: "#{i_c.id}-#{size.id}",
                        item_id: item.id,
                        item_color_id: i_c.id,
                        size_name: size.name,
                        size_id: size.id,
                        public: "true"
                    )
                    sku.save

                    quantity = rand(1..3)

                    stock = Stock.new(
                        sku_id: sku.id,
                        all_quantity: quantity,
                        quantity_in_cart: 0,
                        quantity_on_display: quantity,
                        quantity_in_by: 0
                    )
                    stock.save

                    if register_size_details

                        register_size_details.each do |sd|

                            measuring_value = MeasuringValue.new(
                                sku_id: sku.id,
                                measuring_item_id: sd[:mi_id],
                                measuring_item_name: MeasuringItem.find(sd[:mi_id]).name,
                                value: (index * 2) + sd[:mv]
                            )
                            
                            measuring_value.save
                        end

                    end

                end

                i_c.update(public: "true")
            end

            item.update(number_of_sizes: register_sizes.length, public: "true")
        end

        redirect_to admin_items_url, notice: "各アイテムにサイズを登録しました。"
    end



    def destroy_all

        items = Item.all
        items.each do |i|
            i.update(number_of_sizes: 0)
        end

        measuring_values = MeasuringValue.all
        measuring_values.destroy_all

        skus = Sku.all
        skus.destroy_all

        redirect_to admin_items_url, notice: "skuデータをリセットしました。"
    end

    
end
