Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find", to: "merchants/find#show"
      get "items/find_all", to: 'items/find#index'
      resources :items, only: [:index, :create, :destroy, :update, :show] do
        resources :merchant, only: [:index], controller: 'items/merchant'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchants/items'
      end
    end
  end
end
