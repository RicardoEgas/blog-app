Rails.application.routes.draw do
  mount V1::Base => '/api'
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users

  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: [:create], controller: 'post_likes'
    end
  end
end
