class UsersController < ApplicationController

    def login_form
        @user = User.new  
    end




    def login_before_shopping
        @user = User.find_by(email: session_params[:email])
    
        if @user&.authenticate(session_params[:password])
            session[:user_id] = @user.id

            if current_cart

                add_current_cart_to_users_cart(@user)

            elsif @user.cart.present?
                users_cart = @user.cart
                session[:cart_id] = users_cart.id

                @notice_sentence = "ログインしました。前回カートに入れた商品があります。"
            end
                
            redirect_to root_url, notice: @notice_sentence
        else
            if @user == nil
                flash[:alert] = "登録されていないメールアドレスです"
            else
                flash[:alert] = "パスワードが違います"
            end

            render :login_form
        end
    end





    def login_during_shopping
        @user = User.find_by(email: session_params[:email])
    
        if @user&.authenticate(session_params[:password])
            session[:user_id] = @user.id

            add_current_cart_to_users_cart(@user)

            redirect_to new_order_path, notice: @notice_sentence
        else
            if @user == nil
                flash[:alert] = "登録されていないメールアドレスです"
            else
                flash[:alert] = "パスワードが違います"
            end

            render "orders/new"
        end
    end




    def logout
        reset_session
        redirect_to root_url, notice: "ログアウトしました"
    end
    


    def new
        @user = User.new
    end



    def create
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            if current_cart
                current_cart.update(
                    user_id: @user.id
                )
            end
            redirect_to root_url, notice: "ユーザー「#{@user.first_name}」を登録しました"
        else
            render :new
        end
    end


    
    def create_during_shopping
        @user = User.new(order_params)

        if @user.save
            session[:user_id] = @user.id
            current_cart.update(
                user_id: @user.id
            )
            redirect_to new_order_url, notice: "ユーザー「#{@user.first_name}」を登録しました"
        else
            render "orders/new"
        end
    end
    



    def show
        @user = User.find(params[:id])
        @brands = Brand.all
    end
    



    def edit
    end




    def update
        @user = User.find(params[:id])
    
        if @user.authenticate(user_params[:password]) == false
            @user.errors.add(:password, "が違います")
            render :show
        elsif  @user.update(user_params)
            redirect_to user_url(@user), notice: "ユーザー情報を変更しました。"
        else
            render :show
        end

    end
    



    def purchase_history
        @brands = Brand.all
        @sales = current_user.sales.order(created_at: "DESC")
    end




    def destroy
        user = User.find(params[:id])
        user.destroy
        session[:user_id] = nil

        redirect_to root_url, notice: "退会しました。"
    end




    private

    def user_params
        params.require(:user).permit(
            :family_name,
            :first_name,
            :postal_code,
            :adress,
            :cond_n_room,
            :email,
            :email_confirmation,
            :phonenumber,
            :password,
            :password_confirmation,
            :mail_magazine
            )
    end



    def session_params
        params.require(:session).permit(:email, :password)
    end



    def order_params
        params.require(:order).permit(
            :family_name,
            :first_name,
            :postal_code,
            :adress,
            :cond_n_room,
            :email,
            :email_confirmation,
            :phonenumber,
            :password,
            :password_confirmation,
            :mail_magazine
        )
    end



    def add_current_cart_to_users_cart(user)

        /current_cart有、users_cart有だった時の、item合体後の空のcartを削除するための変数/
        current_cart_id_before_login = nil

        if user.cart.present?

            current_cart_id_before_login = current_cart.id

            users_cart = user.cart

            current_cart.cart_items.each do |cart_item|

                users_cart.cart_items.each do |cart_item_in_users_cart|
                    if cart_item.sku_id == cart_item_in_users_cart.sku_id
                        cart_item.update(
                            quantity: cart_item.quantity + cart_item_in_users_cart.quantity,
                            total_item_price: cart_item.sku.item.price * (cart_item.quantity + cart_item_in_users_cart.quantity),
                            price_w_tax: cart_item.sku.item.price * (cart_item.quantity + cart_item_in_users_cart.quantity) * 1.1
                        )
                        cart_item_in_users_cart.destroy
                    end
                end

                cart_item.update(
                    cart_id: users_cart.id
                )
            end

            session[:cart_id] = users_cart.id
            @notice_sentence = "ログインしました。前回カートに入れた商品があります。"
        else

            current_cart.update(
                user_id: user.id
            )

            @notice_sentence = "ログインしました。"
        end

        /current_cart有、users_cart有だった時の、item合体後の空のcartを削除/
        if current_cart_id_before_login
            Cart.find(current_cart_id_before_login).destroy
        end
        
    end



end



