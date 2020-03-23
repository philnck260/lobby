Rails.application.routes.draw do
  resources :commitments, only: [:show, :index] do
    resources :user_commitments, only: [:create, :destroy]
  end
  root to: "static#home"

  scope "admin", module: "admin", as: "admin" do
    resources :commitments
    resources :users
  end
  

	devise_for :users, controllers: { registrations: "registrations" }
	resources :users, only: [:show, :edit, :update]
	resources :themes, only: [:show, :index]
	resources :contact, only: [:new, :create]

	# STATIC ROUTES
	get '/home' => 'static#home'
	get '/statistics' => 'static#statistics'
	get '/about' => 'static#about'
	get '/faq' => 'static#faq'

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
