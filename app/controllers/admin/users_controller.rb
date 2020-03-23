module Admin
  class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :is_user_admin?

    def index
      @users = User.all
    end

    def edit
      @departement = []
      count = 0
      95.times do
        count += 1
        unless count == 20
          @departement << count.to_s
        end
        if count == 2
          @departement += ["2A", "2B"]
        end
      end
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Vous avez modifié l'utilisateur avec succès"
        redirect_to admin_users_path
      else
        flash[:error] = @user.errors.full_messages.to_sentence
        redirect_to edit_admin_user_path(@user.id)
      end
    end

    def destroy
      @user.destroy
      flash[:success] = "Vous avez supprimé l'utilisateur avec succès"
      redirect_to admin_users_path
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :department, :name_display, :accept_mails)
    end

    def is_user_admin?
      unless current_user.role == "admin" && user_signed_in?
        flash[:warning] = "Vous n'êtes pas Administrateur."
        redirect_to root_path
      end
    end
  end
end
