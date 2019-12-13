class ItemsController < ApplicationController
    before_action :brand_exist?, only: [:new, :create_10_data_for_each_brand]

    def brand_exist?
        if Brand.all.empty?
            redirect_to home_back_office_url, notice: "brandを登録してください。"
        end
    end

    def show
    end

    def new_test
    end

    def new_test2
    end


    def index
        @items = Item.all
    end



    def new


        brand = Brand.order("RANDOM()").first

        create_sample_data(brand)

        redirect_to items_url, notice: "「#{@sample_item.name}」を作成しました。"
    end



    def create_10_data_for_each_brand
        Brand.all.each do |brand|
            10.times do
                create_sample_data(brand)
            end
        end

        redirect_to items_url, notice: "各ブランドに10アイテムを作成しました。"

    end




    def destroy
        item = Item.find(params[:id])
        item.destroy
        redirect_to items_url, notice: "「#{item.brand.name} '#{item.name}'」を削除しました。"
    end


    def destroy_all
        items = Item.all
        items.destroy_all
        redirect_to items_url, notice: "itemsデータをリセットしました。"
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
        
        if Item.all.empty?
            last_item_id = 0
        else
            last_item_id = Item.last.id
        end

        item_category_and_example = get_item_category_and_example(rand(1..7))
        item_category = item_category_and_example[:category_name]
        item_example = item_category_and_example[:example_item]

        rand_price = rand(6..15) * 1000

        @sample_item = Item.new(
            id: last_item_id + 1,
            name: "#{item_example} 0#{last_item_id + 1}",
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

    end


end

