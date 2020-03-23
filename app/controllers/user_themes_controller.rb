class UserThemesController < ApplicationController

	def create
		@user_theme = UserTheme.new
		@user_theme.theme = Theme.find(params[:theme_id])
		@user_theme.user = current_user
		@user_theme.save
		flash[:success] = 'Vous suivez ce Thème.'
		redirect_to theme_path(@user_theme.theme.id)
	end

	def destroy
		@user_theme = UserTheme.find(params[:id])
		@user_theme.destroy
		flash[:success] = 'Vous ne suivez plus ce Thème.'
		redirect_to theme_path(@user_theme.theme.id)
	end

end
