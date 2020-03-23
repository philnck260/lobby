Rails.application.routes.draw do
  root to: "static#home"

  resources :commitments, only: [:show, :index] do
    resources :user_commitments, only: [:create, :destroy]
  end

  scope "admin", module: "admin", as: "admin" do
    resources :commitments
    resources :users
  end

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show, :edit, :update]
  resources :themes, only: [:show, :index]
  resources :contact, only: [:new, :create]

  resources :posts do
    resources :replies, only: [:new, :create, :edit, :update, :destroy]
  end

  # STATIC ROUTES
  get "/home" => "static#home"
  get "/statistics" => "static#statistics"
  get "/about" => "static#about"
  get "/faq" => "static#faq"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
