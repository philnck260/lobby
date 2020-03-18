Rails.application.routes.draw do

	resources :commitments, only: [:show, :index] do
		resources :user_commitments, only: [:create, :destroy]
	end
	root to: "commitments#index"


	get '/statistics' => 'static#statistics'
	get '/Contact' => 'static#contact'
	get '/About' => 'static#about'
	get '/FAQ' => 'static#faq'

	devise_for :users, controllers: { registrations: "registrations" }
	resources :users, only: [:show, :edit, :update]


	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
