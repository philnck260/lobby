class StaticController < ApplicationController
  def contact
    render params[:page]
    puts params
  end

  def faq
    render params[:page]
    puts params
  end

  def about
    render params[:page]
    puts params
  end
end
