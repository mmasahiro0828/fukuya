Rails.application.routes.draw do

  #フロント画面用↓
  root to: 'home#top'

  resources :brands, only: :show

  get "/items/searched_item_index", to: "items#searched_item_index"
  resources :items, only: [:index, :show]

  resources :topics, only: :show

  get "/users/login_form", to: "users#login_form"
  post "/users/login_before_shopping", to: "users#login_before_shopping"
  post "/users/login_during_shopping", to: "users#login_during_shopping"
  post "/users/create_during_shopping", to: "users#create_during_shopping"
  get "/users/logout", to: "users#logout"
  get "/users/purchase_history", to: "users#purchase_history"
  resources :users


  
  post "/cart_items/delete_1", to: "cart_items#delete_1"
  resources :cart_items, only: [:index, :create, :destroy]

  post "/orders/new_for_payment", to: "orders#new_for_payment"
  post "/orders/confirmation", to: "orders#confirmation"
  get "/orders/thank_you", to: "orders#thank_you"
  resources :orders, only: [:create, :new]

  resources :likes


  #管理者用↓
  namespace :admin do

    root to: 'home#top'

    get "home/back_office", to: "home#back_office_top"
    get "home/login_form", to: "home#login_form"
    post "home/login_to_bo", to: "home#login_to_bo"
    get "home/put_testdata", to: "home#put_testdata"

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
    post "items/details_form", to: "items#details_form"
    post "items/confirmation", to: "items#confirmation"
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
