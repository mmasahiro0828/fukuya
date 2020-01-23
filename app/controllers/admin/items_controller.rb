class Admin::ItemsController < ApplicationController

    before_action :admin_user_required

    before_action :brand_exist?, only: [:new, :create_10_data_for_each_brand]

    

    /action内に入れる/
    def brand_exist?
        if Brand.all.empty?
            redirect_to "/admin/home/back_office", notice: "brandを登録してください。"
        end
    end




    def index
        @items = Item.all.order(:id)
    end


    def show
        @item = Item.find(params[:id])
        @item_colors = @item.item_colors.order(:color_id)
        @skus = @item_colors.first.skus.order(:created_at)
        @measuring_items = @skus.first.measuring_items.order(:id)
        @measuring_values = @item.measuring_values

        measuring_items_pattern(@item.category)
    end



    def new
        @item = Item.new
        @brands = Brand.all 
    end



    def details_form
        @item = Item.new(item_params)

        unless @item.valid?
            @brands = Brand.all
            render "admin/items/new"
        end

        @colors = Color.all
        @sizes = Size.all
        @measuring_items = MeasuringItem.all

        measuring_items_pattern(@item.category)
    end



    def confirmation
        @item = Item.new(item_params)
        @color_ids = []
        @size_ids = []

        measuring_items_pattern(@item.category)

        @item.number_of_colors.times do |index|
            @color_ids.push(params[:item]["color_#{index+1}"].to_i)
        end

        @item.number_of_sizes.times do |index|
            @size_ids.push(params[:item]["size_#{index+1}_name"].to_i)
        end

        unless @color_ids.group_by{|i| i}.reject{|k,v| v.one?}.keys.empty?
            @colors = Color.all
            @sizes = Size.all
            @measuring_items = MeasuringItem.all
            @error_message = "1つのアイテムに、同じカラーは登録できません"
            render "admin/items/details_form"
            return
        end

        unless @size_ids.group_by{|i| i}.reject{|k,v| v.one?}.keys.empty?
            @colors = Color.all
            @sizes = Size.all
            @measuring_items = MeasuringItem.all
            @error_message = "1つのアイテムに、同じサイズは登録できません"
            render "admin/items/details_form"
            return
        end

        measuring_items_pattern(@item.category)
    end


    def create
        @item = Item.new(item_params)
        @item.save
        @color_ids = params[:item][:color_ids].split
        @size_ids = params[:item][:size_ids].split

        measuring_items_pattern(@item.category)

        
        @color_ids.each do |c_id|
            item_color = @item.item_colors.new(
                id: "#{@item.id}-#{Color.find(c_id).code}",
                color_name: Color.find(c_id).name,
                color_id: c_id
            )
            item_color.save

            @size_ids.each_with_index do |s_id, i|
                sku = item_color.skus.new(
                    id: "#{item_color.id}-#{s_id}",
                    item_id: @item.id,
                    size_name: Size.find(s_id).name,
                    size_id: s_id
                )
                sku.save

                if @category_pattern == 1
                    @register_measuring_items_ids.each do |mi_id|
                        measuring_value = sku.measuring_values.new(
                            measuring_item_id: mi_id,
                            measuring_item_name: MeasuringItem.find(mi_id).name,
                            value: params[:item]["size_#{i+1}_detail_#{mi_id}"]
                        )
                        measuring_value.save
                    end
                end

                @stock = Stock.new(
                    sku_id: sku.id,
                    quantity_on_display: 0,
                    quantity_in_by: 0,
                )
                @stock.save
            end
        end

        redirect_to admin_item_url(@item), notice: "「#{@item.brand.name} #{@item.name}」を登録しました"
    end


    

    /==========================================================/

    def new_for_test
        brand = Brand.all.sample
        create_sample_data(brand)
        redirect_to admin_items_url, notice: "「#{@sample_item.name}」を作成しました。"
    end



    def create_10_data_for_each_brand
        Brand.all.each do |brand|
            10.times do
                create_sample_data(brand)
            end
        end

        redirect_to admin_items_url, notice: "各ブランドに10アイテムを作成しました。"

    end




    def destroy
        item = Item.find(params[:id])
        item.destroy
        redirect_to admin_items_url, notice: "「#{item.brand.name} '#{item.name}'」を削除しました。"
    end


    def destroy_all
        items = Item.all
        items.destroy_all
        redirect_to admin_items_url, notice: "itemsデータをリセットしました。"
    end



    #テスト用メソッド↓

    def get_item_category_and_example(n)

        item_category_1 = {"category_name": "アウター", "example_item": "JACKET"}
        item_category_2 = {"category_name": "トップス", "example_item": "SHIRT"}
        item_category_3 = {"category_name": "ボトムス", "example_item": "DENIM"}
        item_category_4 = {"category_name": "シューズ", "example_item": "SNEAKERS"}
        item_category_5 = {"category_name": "バッグ", "example_item": "BACK PACK"}
        item_category_6 = {"category_name": "アクセサリー", "example_item": "KNIT CAP"}
        item_category_7 = {"category_name": "その他", "example_item": "SOCKS"}

        case n
        when 1
            item_category_1
        when 2
            item_category_2
        when 3
            item_category_3
        when 4
            item_category_4
        when 5
            item_category_5
        when 6
            item_category_6
        when 7
            item_category_7
        end
    end

    


    def create_sample_data(selected_brand)
        
        item_category_and_example = get_item_category_and_example(rand(1..7))
        item_category = item_category_and_example[:category_name]
        item_example = item_category_and_example[:example_item]

        rand_price = rand(6..15) * 1000

        @sample_item = Item.new(
            brand_id: selected_brand.id,
            description_1: "#{selected_brand.name}の#{item_example}です。",
            description_2: "素材:◯◯、◯◯",
            category: item_category,
            price: rand_price,
            wholesale_price: (rand_price * selected_brand.rate_of_retail_price) / 100,
            sale_price: rand_price,
            public: "false"
        )
        @sample_item.save

        @sample_item.update(
            name: "#{item_example} 0#{@sample_item.id}"
        )


        

    end


    /==========================================================/


    private

    def item_params
        params.require(:item).permit(
            :brand_id,
            :name,
            :description_1,
            :description_2,
            :category,
            :price,
            :wholesale_price,
            :number_of_colors,
            :number_of_sizes
        )
    end

    def measuring_items_pattern(category)
        case category
        when "アウター", "トップス", "ボトムス"
            @category_pattern = 1
        else 
            @category_pattern = 2
        end

        case category
        when "アウター", "トップス"
            @register_measuring_items_ids = [1, 2, 3, 4]
        when "ボトムス"
            @register_measuring_items_ids = [5, 6, 7, 8, 9]
        else
            @register_measuring_items_ids = nil
        end
    end


    def ununique
        group_by{|i| i}.reject{|k,v| v.one?}.keys
    end

end
