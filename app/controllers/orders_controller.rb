class OrdersController < ApplicationController
    def new
        @order = Order.new
    end


    def create
    end
    
    def new_for_payment

        user = current_user
        /ゲストユーザーで変更する/

        @order = Order.new(
            user_id: user.id,
            total_item_price: user.cart_items.sum(:price_w_tax),
            discount: 0,
            fee: 0,
            final_price: user.cart_items.sum(:price_w_tax),
            method_of_payment: "yet",
            user_name: "#{order_params_1[:family_name]} #{order_params_1[:first_name]}",
            user_email: order_params_1[:email],
            user_email_confirmation: order_params_1[:email_confirmation],
            shipping_postal_code: order_params_1[:postal_code],
            shipping_adress: order_params_1[:adress],
            shipping_cond_n_room: order_params_1[:cond_n_room],
            user_phonenumber: order_params_1[:phonenumber],
            shipping_date: "yet"
        )

        unless @order.valid?
            render :new
        end
        
        @date_selection = date_selection
        
    end




    def confirmation
        @order = Order.new(order_params_2)
        @date_selection = date_selection

        unless @order.valid?
            render :new_for_payment
        end

        @order.shipping_date = "#{order_params_3[:shipping_date_1]} #{order_params_3[:shipping_date_2]}"

        @cart_items = User.find(@order.user_id).cart_items

        /cart情報をviewに反映/
        /@order情報をviewにform_withで反映/
        /やり直す場合、情報入力からやり直すボタン/
        /submitでオーダーのcreate、同じタイミングでsalesもcreateし、cartの削除/
        /create後はthankyouに飛ばす/

    end
    
    def thank_you
    end

    private

    def order_params_1
        params.require(:user).permit(
            :family_name,
            :first_name,
            :postal_code,
            :adress,
            :cond_n_room,
            :email,
            :email_confirmation,
            :phonenumber,
        )
    end

    def order_params_2
        params.require(:order).permit(
            :method_of_payment,
            :id,
            :user_id,
            :total_item_price,
            :discount,
            :fee,
            :final_price,
            :user_name,
            :user_email,
            :user_email_confirmation,
            :shipping_postal_code,
            :shipping_adress,
            :shipping_cond_n_room,
            :user_phonenumber
        )
    end

    def order_params_3
        params.require(:order).permit(
            :shipping_date_1,
            :shipping_date_2,
            :coupon_code,
        )
    end


    def date_selection
        require "date"
        date = Date.today

        date_selection = ["指定なし"]
        6.times do |i|
            date_selection.push(date_for_display(date + i + 2))
        end

        return date_selection
    end

    def date_for_display(date)
        "#{date.month}月#{date.day}"
    end
    
end
