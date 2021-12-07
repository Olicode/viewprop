Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :listings, only: %i[index show] do
    resources :offers, only: %i[new create]
  end
  resources :offers, only: %i[index show update]
end
