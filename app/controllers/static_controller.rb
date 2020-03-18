class StaticController < ApplicationController
  
  def faq
    render params[:page]
    puts params
  end

  def about
    render params[:page]
    puts params
  end

end
