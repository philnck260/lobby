Rails.application.routes.draw do
  root to: "static#home"

  resources :commitments, only: [:show, :index] do
    resources :user_commitments, only: [:create, :destroy]
  end

  scope "admin", module: "admin", as: "admin" do
    resources :commitments
    resources :users
    resources :themes
  end

  resources :forums, only: [:index, :show] do
    resources :posts do
      resources :replies, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show, :edit, :update]
  resources :themes, only: [:show, :index] do
    resources :user_themes, only: [:create, :destroy]
  end
  resources :contact, only: [:new, :create]

  # STATIC ROUTES
  get "/home" => "static#home"
  get "/statistics" => "static#statistics"
  get "/about" => "static#about"
  get "/donate" => "static#donate"
  get "/rgpd" => "static#rgpd"


  resources :charges, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
