Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: "pages#dashboard", as: :dashboard
  get '/history', to: "pages#history", as: :history

  resources :listings, only: %i[index show new create edit update] do
    resources :offers, only: %i[new create]
    resources :bookings, only: %i[new create]
  end
  resources :offers, only: %i[show edit update]
  resources :bookings, only: %i[show update delete]

  resources :conversations, only: %i[index show] do
    resources :messages, only: :create
  end
end
