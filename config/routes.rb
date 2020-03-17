Rails.application.routes.draw do
  resources :users, only: [:show]
  devise_for :users

  get '/Contact' => 'static#contact'
  get '/About' => 'static#about'
  get '/FAQ' => 'static#faq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
