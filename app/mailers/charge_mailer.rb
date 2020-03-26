class ChargeMailer < ApplicationMailer
  default from: 'adminlobby@yopmail.com'
  def payement_email(charge)
    @charge = charge
    mail(to: @charge.billing_details.name , subject: 'Le Lobby vous dit merci ! Votre don a bien été pris en compte')
  end
end
