class User < ApplicationRecord
    has_many :cart_items
    has_many :sales
    has_many :orders

    validates :family_name, presence: true
    validates :first_name, presence: true
    validates :email, confirmation: true, uniqueness: true
    validates :email_confirmation, presence: true
    validates :phonenumber, presence: true
    validates :password, length: { in: 6..20 }


    has_secure_password
end
