class UsersController < ApplicationController

    def login_form
        @user = User.new  
    end



    def login
        @user = User.find_by(email: session_params[:email])
    
        if @user&.authenticate(session_params[:password])
            session[:user_id] = @user.id
            redirect_to root_url, notice: "ログインしました。"
        else
            if @user == nil
                flash[:alert] = "登録されていないメールアドレスです"
            else
                flash[:alert] = "パスワードが違います"
            end

            render :login_form
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

    def session_params
        params.require(:session).permit(:email, :password)
    end


end



