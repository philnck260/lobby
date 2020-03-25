module Admin
  class ThemesController < ApplicationController
    before_action :find_theme, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :is_user_admin?

    def index
      @themes = Theme.all
    end

		def new
			@theme = Theme.new
			@theme.sources.build
		end

		def create
			@theme = Theme.new(theme_params)
			if @theme.save
				flash[:success] = "Vous avez créé un Thème."
				redirect_to admin_themes_path
			else
				flash[:error] = @theme.errors.full_messages.to_sentence
				redirect_to new_admin_theme_path
			end
		end

		def edit
			# BUILD NEW SOURCE FORM, if count == 1 or == 2
			if @theme.sources.count >= 0 && @theme.sources.count <= 2
				@theme.sources.build
			end
		end

    def update
      if @theme.update(theme_params)
        flash[:success] = "Vous avez bien édité ce Thème."
        redirect_to admin_themes_path
      else
        flash[:error] = @theme.errors.full_messages.to_sentence
        redirect_to edit_admin_theme_path(@theme.id)
      end
    end

    def destroy
      @theme.destroy
      respond_to do |format|
        format.html do
        end
        format.js  do
        end

      end
    end

    private

		def theme_params
			params.require(:theme).permit(:title, :description, sources_attributes: [:id, :title, :media, :url, :description, :category, :_destroy])
		end

    def find_theme
      @theme = Theme.find(params[:id])
    end

    def is_user_admin?
      unless current_user.role == "admin" && user_signed_in?
        flash[:warning] = "Vous n'êtes pas Administrateur."
        redirect_to root_path
      end
    end
    
  end
end
