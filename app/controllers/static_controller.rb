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

  def soutenez_nous
    render params[:page]
  end

end
