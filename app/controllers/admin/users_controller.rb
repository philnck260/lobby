module Admin
  
    class UsersController < ApplicationController
      before_action :find_user, only: [:edit, :update, :destroy]
      before_action :authenticate_user!
  
      def index
        @users = User.all
      end
  
      def new
        @user = User.new
        
      end
  
      def create
          @user = User.new(user_params)
        if @user.save
          flash[:sucess] = "Vous avez créé un mouvement"
          redirect_to admin_users_path
        else
          flash[:warning] = "Vous n'avez pas réussi à créer un mouvement : le titre et la description doivent avoir respectivement 10 et 20 caractères"
          redirect_to new_admin_user_path
        end
      end
  
      def edit
        @departement = []
    count = 0
    95.times do 
      count += 1
      @departement << count
    end
      end
  
      def update
        @user.update(user_params)
        redirect_to admin_users_path
      end
  
      def destroy
        @user.destroy
        redirect_to admin_users_path
      end
  
      private
  
      def find_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:email, :username, :first_name, :last_name, :department, :name_display)
      end

      def is_user_admin
        unless user_signed_in? && current_user.role == "admin"
          redirect_to root_path
        end
      end

    end
  end
  