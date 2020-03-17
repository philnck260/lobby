class StaticController < ApplicationController
  def contact
    render params[:page]
  end

  def faq
    render params[:page]
  end

  def about
    render params[:page]
  end
end
