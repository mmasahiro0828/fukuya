class BrandsController < ApplicationController

    def index
        @brands = Brand.all
    end

    
    def new
        create_sample_data
        redirect_to brands_url, notice: "「#{@sample_brand.name}」を作成しました。"
    end

    
    def create_10_data
        10.times do
            create_sample_data
        end
        redirect_to brands_url, notice: "「#{Brand.find(Brand.last.id - 9).name} 〜 #{Brand.last.name}」を作成しました。"
    end

    
    def destroy
        brand = Brand.find(params[:id])
        brand.destroy
        redirect_to brands_url, notice: "「#{brand.name}」を削除しました。"
    end

    def destroy_all
        brands = Brand.all
        brands.destroy_all
        redirect_to brands_url, notice: "ブランドデータをリセットしました。"
    end

    private

    def create_sample_data
        if Brand.all.empty?
            last_brand_id = 0
        else
            last_brand_id = Brand.last.id
        end

        random1 = rand(4..6)

        @sample_brand = Brand.new(
            id: last_brand_id + 1,
            name: "sample brand #{last_brand_id + 1}",
            kana_name: "サンプルブランド#{last_brand_id + 1}",
            description: "こんなブランドです。",
            image_name: "img_for_sample_brand.jpg",
            rate_of_retail_price: random1 * 10,
            website: "#",
            public: "true"
        )

        @sample_brand.save
    end


end

