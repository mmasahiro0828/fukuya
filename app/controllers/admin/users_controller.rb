class Admin::UsersController < ApplicationController

    def index
        @users = User.all
    end



    def create_10_sample_users
        10.times do
            if User.all.empty?
                last_user_id = 0
            else
                last_user_id = User.last.id
            end

            user = User.new(
                id: last_user_id + 1,
                family_name: "サンプル",
                first_name: "ユーザー00#{last_user_id + 1}",
                email: "sample00#{last_user_id + 1}@ex.jp",
                email_confirmation: "sample00#{last_user_id + 1}@ex.jp",
                postal_code: 1115555,
                adress: "XX県YY市ZZ 1-2-3",
                cond_n_room: "KKK 402",
                phonenumber: "09011112222",
                password: "password",
                mail_magazine: "true"
            )

            user.save
        end

        redirect_to admin_users_url, notice: "サンプルユーザーを登録しました。"
    end

    def destroy_all
        users = User.all
        users.destroy_all

        redirect_to admin_users_url, notice: "usersデータをリセットしました。"
    end

    
end
