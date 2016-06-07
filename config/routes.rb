Rails.application.routes.draw do
  # get 'users/create'

  # get 'users/update'

  # get 'users/destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root
  # root '#index'

  get '/centers', to: 'centers#index'

  get '/centers/:id', to: 'centers#show'

  get '/centers/geo/:lat/:lng/:radius', to: 'centers#location', :constraints => { :lat => /[^\/]+/, :lng => /[^\/]+/}

  resources :users

  resources :schools do
    resources :posts do
      resources :comments
    end
  end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
