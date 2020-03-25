class StaticController < ApplicationController

	def home
		render params[:page]
	end

	def statistics
		render params[:page]
	end
  
  def faq
    render params[:page]
  end

  def about
    render params[:page]
  end

  def donate
    render params[:page]
  end

end
