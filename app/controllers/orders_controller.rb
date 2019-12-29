class OrdersController < ApplicationController
    def new
        @order = Order.new
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

        if @order.method_of_payment == "代引き"
            @order.fee = 380
        end

        /discount処理/

        @order.final_price = @order.total_item_price + @order.fee - @order.discount

        @order.shipping_date = "日: #{order_params_3[:shipping_date_1]} / 時間: #{order_params_3[:shipping_date_2]}"

        @cart_items = User.find(@order.user_id).cart_items
    end
    

    def create
        order = Order.new(order_params_4)
        order.save

        cart_items = User.find(order.user_id).cart_items
        
        cart_items.each do |cart_item|
            sale = order.sales.new(
                user_id: cart_item.user_id,
                sku_id: cart_item.sku_id,
                quantity: cart_item.quantity,
                total_item_price: cart_item.total_item_price,
                discount: cart_item.discount,
                price_w_tax: cart_item.price_w_tax
            )

            sale.save

            cart_item.sku.stock.update(
                all_quantity: cart_item.sku.stock.all_quantity - cart_item.quantity,
                quantity_in_cart: cart_item.sku.stock.quantity_in_cart - cart_item.quantity
            )
            
            cart_item.destroy
        end

        redirect_to orders_thank_you_path(id: order.id)

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


    def order_params_4
        params.require(:order).permit(
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
            :user_phonenumber,
            :method_of_payment,
            :shipping_date
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
