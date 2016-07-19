Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users

  resource :login, only: [:create], controller: :sessions

  resources :schools do
    resources :posts do
      resources :comments
    end
  end

  # root to: "users#index"
  get '/flags/:user_id', to: 'flags#show'

  post '/flags', to: 'flags#create'

  delete '/flags/:id', to: 'flags#destroy'
  # get 'sessions/create'

  # get 'sessions/destroy'

  # get 'users/create'

  # get 'users/update'

  # get 'users/destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root
  # root '/'


  # resources :users

  # post '/login', to: 'sessions#create'



  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
