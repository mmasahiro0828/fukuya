class CartItemsController < ApplicationController
    
    def index
        @brands = Brand.all
        @cart_items = current_cart&.cart_items
        @total_price_of_cart_items = @cart_items&.sum(:price_w_tax)
    end


    
    def create

        /在庫check/
        sku = Sku.find_by(id: params[:format])

        /renderをうまくとばせない/
        if sku.stock.quantity_on_display > 0
            sku.stock.update(
                quantity_in_cart: sku.stock.quantity_in_cart + 1,
                quantity_on_display: sku.stock.quantity_on_display - 1
            )
        else
            render "items/show", alert: "希望した商品の在庫がございません。"
        end

        /すでにcartを持っているかcheck/
        if session[:cart_id]
            cart = Cart.find(session[:cart_id])
        else
            if current_user
                cart = Cart.new(user_id: current_user.id)
            else
                cart = Cart.new
            end

            cart.save
            session[:cart_id] = cart.id
        end
        
        cart_item = cart.cart_items.find_by(sku_id: sku.id)
        
        if cart_item
            cart_item.update(
                quantity: cart_item.quantity + 1,
                total_item_price: cart_item.sku.item.price * (cart_item.quantity + 1),
                price_w_tax: (cart_item.sku.item.price * (cart_item.quantity + 1) * 1.10).round
                )

            redirect_to cart_items_url, notice: "「#{sku.item.name}」をカートに入れました。"
        else
            cart_item = cart.cart_items.new(
                sku_id: sku.id,
                quantity: 1,
                total_item_price: sku.item.price,
                discount: 0,
                price_w_tax: (sku.item.price * 1.10).round
            )
            
            if cart_item.save
                redirect_to cart_items_url, notice: "「#{sku.item.name}」をカートに入れました。"
            else
                render "items/show/#{params[:format]}"
            end
        end       
    end




    def destroy
        cart_item = CartItem.find(params[:id])
        
        cart_item.sku.stock.update(
            quantity_in_cart: cart_item.sku.stock.quantity_in_cart - cart_item.quantity,
            quantity_on_display: cart_item.sku.stock.quantity_on_display + cart_item.quantity
        )

        cart_item.destroy

        unless cart_item.cart.cart_items.present?
            cart_item.cart.destroy
            session[:cart_id] = nil
        end

        redirect_to cart_items_url
    end




    
    def delete_1
        cart_item = CartItem.find(params[:format])

        cart_item.sku.stock.update(
            quantity_in_cart: cart_item.sku.stock.quantity_in_cart - 1,
            quantity_on_display: cart_item.sku.stock.quantity_on_display + 1
        )

        cart_item.update(
            quantity: cart_item.quantity - 1,
            total_item_price: cart_item.sku.item.price * (cart_item.quantity - 1),
            price_w_tax: (cart_item.sku.item.price * (cart_item.quantity - 1) * 1.1).round
        )

        redirect_to cart_items_url
    end


    /自動で行いたい処理/

    def automatic_deletion
        Cart_items.all.each do |cart_item|
            if Time.now.to_i - cart_item.updated_at.to_i > 24 * 60 * 60

                cart_item.sku.stock.update(
                    quantity_in_cart: cart_item.sku.stock.quantity_in_cart - cart_item.quantity,
                    quantity_on_display: cart_item.sku.stock.quantity_on_display + cart_item.quantity
                )

                cart_item.destroy

                unless cart_item.cart.cart_items.present?
                    cart_item.cart.destroy
                end
            end
        end         
    end

end




