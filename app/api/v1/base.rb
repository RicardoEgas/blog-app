module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
  
      resource :users do
        params do
          requires :user_id, type: Integer
        end
  
        route_param :user_id do
          desc 'List all posts for a user'
          get '/posts' do
            user = User.find(params[:user_id])
            user.posts
          end
  
          desc 'List all comments for a user\'s post'
          get '/posts/:post_id/comments' do
            user = User.find(params[:user_id])
            post = user.posts.find(params[:post_id])
            post.comments
          end
        end
      end
    end
  end
  