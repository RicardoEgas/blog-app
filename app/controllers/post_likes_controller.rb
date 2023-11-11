class PostLikesController < ApplicationController
  before_action :find_user_and_post

  def create
    @like = @post.likes.create(author: @user)
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end

  private

  def find_user_and_post
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end
end
