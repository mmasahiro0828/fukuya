class Admin::BrandsController < ApplicationController
    
    before_action :admin_user_required

    
    def index
        @brands = Brand.all
    end

    
    def new
        create_sample_data
        redirect_to admin_brands_url, notice: "「#{@sample_brand.name}」を作成しました。"
    end

    
    def create_10_data
        10.times do
            create_sample_data
        end
        redirect_to admin_brands_url, notice: "「#{Brand.find(Brand.last.id - 9).name} 〜 #{Brand.last.name}」を作成しました。"
    end

    
    def destroy
        brand = Brand.find(params[:id])
        brand.destroy
        redirect_to admin_brands_url, notice: "「#{brand.name}」を削除しました。"
    end

    def destroy_all
        brands = Brand.all
        brands.destroy_all
        redirect_to admin_brands_url, notice: "ブランドデータをリセットしました。"
    end

    #テスト用メソッド↓

    def create_sample_data
        
        random1 = rand(4..6)

        @sample_brand = Brand.new(
            name: "yet",
            kana_name: "yet",
            description: "こんなブランドです。",
            image_name: "img_for_sample_brand.jpg",
            rate_of_retail_price: random1 * 10,
            website: "#",
            public: "true"
        )

        @sample_brand.save

        @sample_brand.update(
            name: "sample brand #{@sample_brand.id}",
            kana_name: "サンプルブランド#{@sample_brand.id}"
        )

        
    end

end
