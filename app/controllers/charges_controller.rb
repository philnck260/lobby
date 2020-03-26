class ChargesController < ApplicationController

  def new
    if params[:@amount].to_i < 1 || params[:@amount] == nil
      @amount = 1
    else
      @amount = params[:@amount].to_i
    puts "ICI se trouve des valeur !"
    puts params[:@amount]
    puts @amount
    end
  end

  def create
    if params[:@amount].to_i < 0 || params[:@amount] == nil
      @amount = 1
    else
    puts "ICI se trouve des valeur !"
    puts params[:@amount]
    puts @amount
    @amount = params[:@amount].to_i
    end
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
       customer: customer.id,
       amount: @amount * 100 ,
       description: 'Rails Stripe customer',
       currency: 'eur'
    })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
