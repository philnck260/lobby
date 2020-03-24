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
				@commitment.commitment_themes.each do |ct|
					ct.build_theme

			end
		end

		def create
			puts "=" * 60 + "\n" + commitment_params[:commitment_themes_attributes]["0"][:theme].to_s + "\n" + "=" * 60
			@commitment = Commitment.new(commitment_params)
			ct = CommitmentTheme.new(commitment: @commitment, theme: Theme.find(commitment_params[:commitment_themes_attributes]["0"][:theme_id]))
			
			if @commitment.save
				flash[:success] = "Vous avez créé un mouvement"
				redirect_to admin_commitments_path
			else
				flash[:error] = @commitment.errors.full_messages.to_sentence
				redirect_to new_admin_commitment_path
			end
		end

		def edit
		end

		def update
			if @commitment.update(commitment_params)
			flash[:success] = 'Vous avez bien édité ce mouvement'
			redirect_to admin_commitments_path
			else
			flash[:error] = @commitment.errors.full_messages.to_sentence
			redirect_to edit_admin_commitment_path(@commitment.id)
			end
		end

		def destroy
			@commitment.destroy
			flash[:success] = 'Vous avez bien supprimé ce mouvement'
			redirect_to admin_commitments_path
		end

		private

		def find_commitment
			@commitment = Commitment.find(params[:id])
		end

		def commitment_params
			params.require(:commitment).permit(:title, :description, commitment_themes_attributes: [:theme_id])
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
