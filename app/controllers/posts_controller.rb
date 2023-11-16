class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 2)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(user_id: @user.id, id: @post.id), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # app/controllers/posts_controller.rb

  # app/controllers/posts_controller.rb

  def destroy
    @post = Post.includes(:likes).find(params[:id])
    Comment.where(post_id: @post.id).destroy_all
    @author = @post.author
    @author.decrement!(:post_counter)
    @post.likes.destroy_all
    @post.destroy

    redirect_to user_posts_path(id: @author.id), notice: 'Post successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
