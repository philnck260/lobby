class ForumsController < ApplicationController
  def index
		@commitments = Commitment.all
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
  end
  
end
