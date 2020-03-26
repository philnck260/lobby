class ChargeMailer < ApplicationMailer
  default from: 'adminlobby@yopmail.com'
  def payement_email(charge)
    @charge = charge
    mail(to: @charge.receipt_email , subject: 'Votre donation à bien était prit en compte !')
  end
end
