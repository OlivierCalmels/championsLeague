# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tournaments#index'

  resources :tournaments, only: %i[index create destroy] do
    resources :groups, only: %i[index show]
    resources :draws, only: %i[index show destroy_all] do
      collection do
        delete :destroy_all
      end
    end
  end
end
