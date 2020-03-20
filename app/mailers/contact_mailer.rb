class ContactMailer < ApplicationMailer


  def contact_email(email,subject,content)
    @email = email
    @subject = subject
    @content = content
    User.where(role: "admin").each do |admin|
      mail(to: admin.email, from: email, subject: subject, content: content).deliver
    end
  end

end

