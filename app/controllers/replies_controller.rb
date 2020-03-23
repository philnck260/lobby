class RepliesController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  before_action :set_reply, only: [:edit, :update, :destroy]

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(post: @post, user: current_user, content: params[:content])
    if @reply.save
      flash[:succes] = 'Vous avez répondu à ce post'
      redirect_to post_path(@post)
    else
      flash[:error] = @reply.errors.full_messages.to_sentence
      redirect_to new_post_reply(@post)
    end
  end

  def edit
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
