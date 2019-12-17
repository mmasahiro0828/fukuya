Rails.application.routes.draw do
  get 'colors/index'
  root to: 'home#top'

  #テスト用↓
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
  


  #テスト用2↓
  resources :brands, only: :show

  resources :items, only: [:index, :show]
  
  resources :stocks

  resources :topics, only: :show

  resources :users


  #管理者用↓
  namespace :admin do

    root to: 'home#back_office_top'

    get "home/back_office", to: "home#back_office_top"

    get "brands/create_10_data", to: "brands#create_10_data"
    get "brands/delete_all", to: "brands#destroy_all"
    resources :brands

    get "colors/create_color_map", to: "colors#create_color_map"
    get "colors/delete_all", to: "colors#destroy_all"
    resources :colors

    get "sizes/create_size_map", to: "sizes#create_size_map"
    get "sizes/delete_all", to: "sizes#destroy_all"
    resources :sizes

    get "measuring_items/create_measuring_items_map", to: "measuring_items#create_measuring_items_map"
    get "measuring_items/delete_all", to: "measuring_items#destroy_all"
    resources :measuring_items

    get "items/create_10_data_for_each_brand", to: "items#create_10_data_for_each_brand"
    get "items/delete_all", to: "items#destroy_all"
    resources :items

    get "item_colors/register_colors_to_each_sample_item", to: "item_colors#register_colors_to_each_sample_item"
    get "item_colors/delete_all", to: "item_colors#destroy_all"

    get "skus/register_sizes_to_each_sample_item", to: "skus#register_sizes_to_each_sample_item"
    get "skus/delete_all", to: "skus#destroy_all"

    resources :stocks

    get "topics/create_topic_with_random_items", to: "topics#create_topic_with_random_items"
    get "topics/delete_all", to: "topics#destroy_all"
    resources :topics

    get "users/create_10_sample_users", to: "users#create_10_sample_users"
    get "users/delete_all", to: "users#destroy_all"
    resources :users

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
