class Order < ApplicationRecord
  belongs_to :user, optional: true, dependent: :nullify
  has_many :sales, dependent: :nullify

  validates :user_email, confirmation: true
  validates :user_email_confirmation, presence: true
  validates :user_phonenumber, presence: true
  validates :shipping_adress, presence: true
  validates :shipping_postal_code, presence: true
  validates :method_of_payment, presence: true

end
