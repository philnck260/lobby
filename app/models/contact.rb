class Contact < ActionMailer::Base
  def contact_send
    ContactMailer.contact_email(self).deliver_now
  end
end
