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
		@total_stripe = total_stripe
    render params[:page]
  end

	private

	def total_stripe
		total = 0
		if Stripe::Charge.list
			Stripe::Charge.list.each do |each_charge|
				total += each_charge.amount / 100
			end
		end
		return total
	end

end
