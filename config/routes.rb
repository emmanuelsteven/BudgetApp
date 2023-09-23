Rails.application.routes.draw do

  devise_for :users
  
  authenticated :user do
    root to: "categories#index", as: :authenticated_root
  end
    root 'splash#index'
    resources :categories, only: [:index, :new, :create, :destroy] do
      resources :purchases, only: [:index, :new, :create, :destroy]
    end
end

