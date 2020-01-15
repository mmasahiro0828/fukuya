class ApplicationController < ActionController::Base

    helper_method :current_user
    helper_method :current_cart
    helper_method :admin_user


    private
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def current_cart
        @current_cart ||= Cart.find_by(id: session[:cart_id]) if session[:cart_id]
    end

    def admin_user
        @admin_user ||= current_user if current_user&.admin == true
    end

    def admin_user_required
        redirect_to root_url, notice: "管理者権限があるアカウントでログインしてください" unless admin_user
    end

    def authenticated_user_required
        unless current_user.id == params[:id].to_i
            redirect_to root_path, notice: "権限がありません"
        end
    end

    def guest_user_required
        if current_user
            redirect_to root_path, notice: "ログイン中は使えません"
        end
    end
            

end
