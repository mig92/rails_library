Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :wishlists
  resources :loans
  resources :books


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  resources :users, path: "custom_user"
end
