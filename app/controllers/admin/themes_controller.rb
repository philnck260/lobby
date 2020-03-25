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
    end

    def create
      @theme = Theme.new(theme_params)
      if @theme.save
        flash[:success] = "Vous avez créé un Thème."
        redirect_to admin_commitments_path
      else
        flash[:error] = @theme.errors.full_messages.to_sentence
        redirect_to new_admin_theme_path
      end
    end

    def edit
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

    def find_theme
      @theme = Theme.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:title, :description)
    end

    def is_user_admin?
      unless current_user.role == "admin" && user_signed_in?
        flash[:warning] = "Vous n'êtes pas Administrateur."
        redirect_to root_path
      end
    end
  end
end
