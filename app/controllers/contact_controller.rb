class ContactController < ApplicationController
    
    def new
        @contact = Contact.new
    end

    def create
      email = params[:email]
      content = params[:content]
      ContactMailer.contact_email(email, content).deliver
      redirect_to root_path
    end
end
