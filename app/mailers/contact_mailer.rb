class ContactMailer < ApplicationMailer

  def contact_email(email, content)
    @email = email
    @content = content
    mail(from: email,to: 'admilobbynistrator@gmail.com', subject: 'Contact Request')
  end
end
