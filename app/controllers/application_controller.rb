class ApplicationController < ActionController::Base

    helper_method :current_user
    helper_method :current_cart


    private
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def current_cart
        @current_cart ||= Cart.find_by(id: session[:cart_id]) if session[:cart_id]
    end
end
