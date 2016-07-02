Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  # get 'users/create'

  # get 'users/update'

  # get 'users/destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root
  # root '/'

  resources :users

  resources :schools do
    resources :posts do
      resources :comments
    end
  end


  post '/login', to: 'sessions#create'

  get '/flags/:user_id', to: 'flags#show'

  post '/flags', to: 'flags#create'

  delete '/flags/:id', to: 'flags#destroy'


  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
