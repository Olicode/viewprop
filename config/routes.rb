Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: "pages#dashboard", as: :dashboard

  resources :listings, only: %i[index show new create edit update] do
    resources :offers, only: %i[new create]
    resources :bookings, only: %i[new create]
  end
  resources :offers, only: %i[edit update]
  resources :bookings, only: :delete
end
