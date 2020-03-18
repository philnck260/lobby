class Contact < ActionMailer::Base
  after_action :contact_send
  
    def contact_send 
      ContactMailer.contact_email(self).deliver_now
    end
  
  end
  