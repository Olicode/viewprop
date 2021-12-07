Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: "pages#dashboard", as: :dashboard

  resources :listings, only: %i[index show]
end
