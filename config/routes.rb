Rails.application.routes.draw do

  devise_for :users
  
  authenticated :user do
    root to: "categories#index", as: :authenticated_root
  end
    root 'splash#index'
    resources :categories, only: [:index, :show, :new, :create, :destroy, :update] do
      resources :purchases, only: [:index, :new, :create, :destroy, :edit, :update]
    end
  end

