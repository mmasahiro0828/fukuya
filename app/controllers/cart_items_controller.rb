class CartItemsController < ApplicationController
    
    def index
        @cart_items = current_user.cart_items
        @total_price_of_cart_items = @cart_items.sum(:price_w_tax)
    end


    
    def create
        sku = Sku.find_by(id: params[:format])

        if sku.stock.quantity_on_display > 0
            sku.stock.update(
                quantity_in_cart: sku.stock.quantity_in_cart + 1,
                quantity_on_display: sku.stock.quantity_on_display - 1
            )
        else
            render "items/show/#{params[:format]}", alert: "希望した商品の在庫がございません。"
        end
        
        cart_item = CartItem.where(user_id: current_user.id).find_by(sku_id: sku.id)

        if cart_item
            cart_item.update(
                quantity: cart_item.quantity + 1,
                total_item_price: cart_item.sku.item.price * (cart_item.quantity + 1),
                price_w_tax: cart_item.sku.item.price * (cart_item.quantity + 1) * 1.1
                )

            redirect_to cart_items_url, notice: "「#{sku.item.name}」をカートに入れました。"
        else
            cart_item = current_user.cart_items.new(
                sku_id: sku.id,
                quantity: 1,
                total_item_price: sku.item.price,
                discount: 0,
                price_w_tax: sku.item.price * 1.1
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
            price_w_tax: cart_item.sku.item.price * (cart_item.quantity - 1) * 1.1
        )

        redirect_to cart_items_url
    end

end




