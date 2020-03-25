module Admin
	class CommitmentsController < ApplicationController
		before_action :find_commitment, only: [:edit, :update, :destroy]
		before_action :authenticate_user!
		before_action :is_user_admin?

		def index
			@commitments = Commitment.all
		end

		def new
			@themes = themes_titles 
			@commitment = Commitment.new
			@commitment.commitment_themes.build 
			@commitment.sources.build
		end

		def create
			@commitment = Commitment.new(commitment_params)
			if @commitment.save
				flash[:success] = "Vous avez créé un Mouvement.\nVous pouvez ajouter un second Thème au Mouvement créé en l'Éditant."
				redirect_to admin_commitments_path
			else
				flash[:error] = @commitment.errors.full_messages.to_sentence
				redirect_to new_admin_commitment_path
			end
		end

		def edit
			# BUILD NEW COMMITMENT_THEME FORM, if count == 0 or == 1
			if @commitment.themes.count == 0 || @commitment.themes.count == 1
				@commitment.commitment_themes.build
			end
			# BUILD NEW SOURCE FORM, if 0 <= count <= 2
			if @commitment.sources.count >=0 && @commitment.sources.count <= 2
				@commitment.sources.build
			end
		end

		def update
			if @commitment.update(commitment_params)
				flash[:success] = 'Vous avez bien édité ce Mouvement'
				redirect_to admin_commitments_path
			else
				flash[:error] = @commitment.errors.full_messages.to_sentence
				redirect_to edit_admin_commitment_path(@commitment.id)
			end
		end

		def destroy
			@commitment.destroy
			flash[:success] = 'Vous avez bien supprimé ce Mouvement'
			redirect_to admin_commitments_path
		end

		private

		def find_commitment
			@commitment = Commitment.find(params[:id])
		end

		def commitment_params
			params.require(:commitment).permit(:title, :description, commitment_themes_attributes: [:id, :theme_id, :_destroy], sources_attributes: [:id, :title, :media, :url, :description, :category, :_destroy])
		end

		def is_user_admin?
			unless current_user.role == 'admin' && user_signed_in?
				flash[:warning] = "Vous n'êtes pas Administrateur."
				redirect_to root_path
			end
		end

		def themes_titles
			titles_array = Array.new
			Theme.all.each do |each_theme|
				titles_array << each_theme.title
			end	
			return titles_array
		end

	end
end
