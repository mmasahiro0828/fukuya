class OrdersController < ApplicationController
    def new
        @order = Order.new
        @user = User.new
    end

    def new_for_payment

        cart = current_cart

        
        
        @order = Order.new(
            method_of_payment: "yet",
            user_name: "#{order_params_1[:family_name]} #{order_params_1[:first_name]}",
            user_email: order_params_1[:email],
            user_email_confirmation: order_params_1[:email_confirmation],
            shipping_postal_code: order_params_1[:postal_code],
            shipping_adress: order_params_1[:adress],
            shipping_cond_n_room: order_params_1[:cond_n_room],
            user_phonenumber: order_params_1[:phonenumber],
        )

        unless @order.valid?
            render :new
        end
        
        @date_selection = date_selection

        if params[:commit] == "入力した情報で会員登録する"
            @user = User.new(order_params_for_user_create)

            if @user.save
                session[:user_id] = @user.id
                cart.update(user_id: @user.id)
                flash[:notice] = "ユーザー「#{@user.first_name}」を登録しました"
            else
                render "orders/new"
            end
        end
    end



    def confirmation
        @order = Order.new(order_params_2)
        @date_selection = date_selection
        @token ||= params['payjp-token']
        cart = current_cart
        @cart_items = cart.cart_items
    
        unless @order.valid?
            render :new_for_payment
        end


        if @order.method_of_payment == "代引き"
            @order.fee = 380
        else
            @order.fee = 0
        end

        /discount処理/
        @order.discount = 0
        //

        @order.total_item_price = cart.cart_items.sum(:price_w_tax)
        @order.final_price = @order.total_item_price + @order.fee - @order.discount
        @order.shipping_date = "日: #{order_params_3[:shipping_date_1]} / 時間: #{order_params_3[:shipping_date_2]}"
        
    end
    

    def create
        order = Order.new(order_params_2)
        cart = current_cart
        order.user_id = cart.user_id
        order.total_item_price = cart.cart_items.sum(:price_w_tax)

        if order.method_of_payment == "代引き"
            order.fee = 380
        else
            order.fee = 0
        end

        /discount処理/
        order.discount = 0
        //

        order.final_price = order.total_item_price + order.fee - order.discount
        order.save

        if order.method_of_payment == "クレジットカード"
            pay(order.final_price)
        end

        cart_items = current_cart.cart_items
        
        cart_items.each do |cart_item|
            sale = order.sales.new(
                user_id: cart_item.cart.user_id,
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

        cart.destroy
        session[:cart_id] = nil

        redirect_to orders_thank_you_path(id: order.id)

    end
    


    def thank_you
    end

    private

    def order_params_for_user_create
        params.require(:order).permit(
            :password,
            :password_confirmation,
            :mail_magazine,
            :family_name,
            :first_name,
            :postal_code,
            :adress,
            :cond_n_room,
            :email,
            :email_confirmation,
            :phonenumber
        )
    end
    
    def order_params_1
        params.require(:order).permit(
            :family_name,
            :first_name,
            :postal_code,
            :adress,
            :cond_n_room,
            :email,
            :email_confirmation,
            :phonenumber
        )
    end


    def order_params_2
        params.require(:order).permit(
            :method_of_payment,
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
        "#{date.month}月#{date.day}日"
    end


    def pay(amount)
        Payjp.api_key = "sk_test_c9d7b53a525c03c07cc9dec4"
        Payjp::Charge.create(
          :amount => amount,
          :card => params[:order][:payjp_token],
          :currency => 'jpy'
        )
    end
    


end
