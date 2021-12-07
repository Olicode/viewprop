Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :listings, only: %i[index show] do
    resources :offer, only: %i[show update]
  end
end
