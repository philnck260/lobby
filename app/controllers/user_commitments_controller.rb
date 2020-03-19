class UserCommitmentsController < ApplicationController
	
	def create
		@user_commitment = UserCommitment.new
		@user_commitment.commitment = Commitment.find(params[:commitment_id])
		@user_commitment.user = current_user
		@user_commitment.save
		flash[:success] = 'Vous vous êtes bien inscrit à ce mouvement'
		redirect_to commitment_path(@user_commitment.commitment.id)
	end

	def destroy
		@user_commitment = UserCommitment.find(params[:id])
		@user_commitment.destroy
		flash[:success] = 'Vous vous êtes bien désinscrit de ce mouvement'
		redirect_to commitment_path(@user_commitment.commitment.id)
	end	

end
