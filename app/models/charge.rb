class Charge < ApplicationRecord

  def charge_send
    ChargeMailer.payement_email(self).deliver_now
  end
end