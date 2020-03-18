class AdminMailer < ApplicationMailer

    def contact_email(user)
        #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
        @user = user 
        #on définit une variable @url qu'on utilisera dans la view d'e-mail
        @url  = 'http://monsite.fr/login' 
        # c'est cet appel à mail() qui permet d'envoyer l'e-mail en définissant destinataire et sujet.
        User.where(role: "admin").each do |admin|
            mail(to: admin.email, subject: 'Bienvenue chez nous !') 
      end
end
