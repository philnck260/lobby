class ContactMailer < ApplicationMailer


  def contact_email(email,content,subject)
    User.where(role: "admin").each do |admin|
      mail(to: admin.email, from: email, subject: subject).deliver
    end
  end

end

