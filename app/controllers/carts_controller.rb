class CartsController < ApplicationController

    def destroy
        session[:cart_id] = nil

        redirect_to root_url
    end
end
