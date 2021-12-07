Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :listings, only: %i[index show] do
    resources :offer, only: %i[show update]
  end
end
