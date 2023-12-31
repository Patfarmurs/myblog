class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).where(author_id: params[:user_id])
    @user = User.includes(:posts, :comments).find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(author_id: @user, title: params[:post][:title], text: params[:post][:text])
    @post.author_id = @user.id
    @post.save
    redirect_to user_posts_path(@user)
  end
end
