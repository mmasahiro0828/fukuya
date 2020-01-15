class Admin::UsersController < ApplicationController

    before_action :admin_user_required

    def index
        @users = User.all
    end



    def create_10_sample_users
        10.times do

            user = User.new(
                first_name: "yet",
                family_name: "サンプル",
                postal_code: 1115555,
                adress: "XX県YY市ZZ 1-2-3",
                cond_n_room: "KKK 402",
                email: "yet",
                email_confirmation: "yet",
                phonenumber: "09011112222",
                password: "password",
                mail_magazine: "true"
            )
            user.save

            user.update(
                first_name: "ユーザー0#{user.id}",
                email: "sample0#{user.id}@ex.jp",
                email_confirmation: "sample0#{user.id}@ex.jp"
            )
            

            
        end

        redirect_to admin_users_url, notice: "サンプルユーザーを登録しました。"
    end

    def destroy_all
        users = User.all
        users.destroy_all

        redirect_to admin_users_url, notice: "usersデータをリセットしました。"
    end

    
end
