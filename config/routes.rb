Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[create]
      post 'like', to: 'post_likes#create', on: :member, as: :like
    end
  end
end
