Rails.application.routes.draw do
  root to: 'home#top'

  #テスト用↓
  get "/items/show", to: "items#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
