Rails.application.routes.draw do
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users

  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[create]
      resources :likes, only: [:create], controller: 'post_likes'
    end
  end
end
