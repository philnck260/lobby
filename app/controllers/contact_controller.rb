class ContactController < ApplicationController
    
    def new
        @contact = Contact.new
    end

    def create
      email = params[:email]
      content = params[:content]
      ContactMailer.contact_email(email, content).deliver
      flash[:success] = 'Votre message a été envoyé avec succès. Nous vous répondrons dans les plus brefs délais'
      redirect_to root_path
    end
end
