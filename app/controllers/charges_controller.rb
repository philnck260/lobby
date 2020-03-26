class ChargesController < ApplicationController

  def new
    if params[:@amount].to_i < 1 || params[:@amount] == nil
      @amount = 1
    else
      @amount = params[:@amount].to_i
    end
    puts @amount
  end

  def create
    if params[:@amount].to_i < 1 || params[:@amount] == nil
      @amount = 1
    else
    @amount = params[:@amount].to_i
    end
    puts @amount
    puts params[:@amount]
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
    if charge
      ChargeMailer.payement_email(charge).deliver
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path


  end

end
