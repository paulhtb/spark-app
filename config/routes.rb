Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :events, only: %i[index show] do
    resources :bookmarks, only: %i[create]
  end

  resources :tickets, only: %i[show]

  resources :tokens, only: %i[index show update] do # index will be the 'marketplace', where the search logic happens
    resources :cart_items, only: %i[create]
  end

  # We might want to relocate the marketplace to a subdomain such as "https://marketplace.domain.com/" later

  resource :cart, only: %i[show] do
    resources :transactions, only: %i[create]
  end

  resources :cart_items, only: %i[destroy]

  resources :users, only: %i[index] do
    get '/transactions', to: 'transactions#index'
    get '/collection', to: 'users#collection'

  end

  resources :bookmarks, only: %i[index destroy]
end
