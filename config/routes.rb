Rails.application.routes.draw do

  devise_for :users
  
  authenticated :user do
    root to: "categories#index", as: :authenticated_root
  end
    root 'splash#index'
   
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :categories, only: [:index, :new, :create] do
      resources :purchases, only: [:index, :new, :create]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
