class RepliesController < ApplicationController
  before_action :set_post, only: [:create, :update, :destroy]
  before_action :set_reply, only: [:edit, :update, :destroy]

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.user = current_user
    @reply.post = @post
    if @reply.save
      flash[:success] = "Vous avez répondu à ce post"
      redirect_to post_path(@post)
    else
      flash[:error] = @reply.errors.full_messages.to_sentence
      redirect_to new_post_reply_path(@post)
    end
  end

  def edit
    unless authenticate_user! && current_user == @reply.user
      redirect_to root_path
    end
  end

  def update
    if @reply.update(reply_params)
      flash[:success] = "Vous avez édité votre commentaire avec succès"
      redirect_to post_path(@post)
    else
      flash[:error] = @reply.errors.full_messages.to_sentence
      redirect_to edit_post_reply_path(@post, @reply)
    end
  end

  def destroy
    @reply.destroy
    flash[:success] = "Vous avez détruit votre commentaire avec succès"
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
