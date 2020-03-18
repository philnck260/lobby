class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  
  def show
    @user_commitments = UserCommitment.where(user: @user)
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
    redirect_to user_path(current_user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :department, :name_display)
  end
end

