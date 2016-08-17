Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations",
                                      :sessions => "users/sessions"}

  resources :schools, only: [:show]

  resources :posts do
    resources :comments
  end

  resources :flags, only: [:show, :create, :destroy]

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
