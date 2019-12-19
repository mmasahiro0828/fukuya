class UsersController < ApplicationController

    def login
    end
    
    def new
        @user = User.new
    end

    def create
        
        if User.all.empty?
            last_user_id = 0
        else
            last_user_id = Item.last.id
        end

        @user = User.new(user_params)
        @user.id = last_user_id

        if @user.save
            redirect_to root_url, notice: "ユーザー「#{@user.first_name}」を登録しました"
        else
            render :new
        end

    end
    
    def confirmation
    end
    
    def edit
    end
    
    def purchase_history
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


end



