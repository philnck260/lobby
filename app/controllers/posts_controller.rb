class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @reply = Reply.new
    @replies = @post.replies
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "Vous avez créé un nouveau post !"
      redirect_to forum_posts_path
    else
      puts @post.errors.messages
      flash[:error] = @post.errors.full_messages.to_sentence
      redirect_to new_forum_post_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Vous avez édité votre post avec succès"
      redirect_to forum_post_path(@post.forum, @post)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      redirect_to edit_forum_post_path(@post.forum, @post)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Vous avez détruit votre post avec succès"
    redirect_to forum_posts_path
  end


  private 

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
  
end
