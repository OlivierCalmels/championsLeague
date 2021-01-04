Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tournaments#index'

  resources :tournaments, only: [:index, :show, :create, :destroy] do
    resources :groups, only: [:index, :show] do
      resources :teams, only: [:index]
    end
    ressources :matches, only: [:index, :show]
  end
end