class Order < ApplicationRecord
  belongs_to :user
  has_many :sales

  validates :user_email, confirmation: true
  validates :user_email_confirmation, presence: true
  validates :user_phonenumber, presence: true
  validates :shipping_adress, presence: true
  validates :shipping_postal_code, presence: true
  validates :method_of_payment, presence: true

end
