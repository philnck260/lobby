Rails.application.routes.draw do

	resources :commitments, only: [:show, :index] do
		resources :user_commitments, only: [:create, :destroy]
	end
	root to: "commitments#index"

	get '/about' => 'static#about'
	get '/faq' => 'static#faq'

	devise_for :users, controllers: { registrations: "registrations" }
	resources :users, only: [:show, :edit, :update]
	resources :contact, only: [:new, :create]

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
