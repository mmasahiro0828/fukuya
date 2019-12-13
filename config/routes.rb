Rails.application.routes.draw do
  root to: 'home#top'

  #テスト用↓
  get "/items/show", to: "items#show"
  get "/cart_items/index", to: "cart_items#index"
  get "/sales/new", to: "sales#new"
  get "/sales/new_for_payment", to: "sales#new_for_payment"
  get "/sales/new_for_confirmation", to: "sales#new_for_confirmation"
  get "/sales/thank_you", to: "sales#thank_you"
  get "/users/login", to: "users#login"
  get "/users/new", to: "users#new"
  get "/users/confirmation", to: "users#confirmation"
  get "/users/edit", to: "users#edit"
  get "/users/purchase_history", to: "users#purchase_history"
  get "/items/new_test", to: "items#new_test"
  get "/items/new_test2", to: "items#new_test2"
  get "/home/back_office", to: "home#back_office_top"


  #テスト用2↓
  get "brands/create_10_data", to: "brands#create_10_data"
  get "brands/delete_all", to: "brands#destroy_all"
  resources :brands

  get "items/create_10_data_for_each_brand", to: "items#create_10_data_for_each_brand"
  get "items/delete_all", to: "items#destroy_all"
  resources :items
  
  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
