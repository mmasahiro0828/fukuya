class Admin::HomeController < ApplicationController

    def login_form
        @user = User.new
    end

    def login_to_bo
        @user = User.new
        pass = "p@ssword"
        if params[:user][:password] == pass
            redirect_to "/admin/home/back_office"
        else
            render "admin/home/login_form"
        end
    end

    def back_office_top
    end
end
