class CommitmentsController < ApplicationController

	def show
		@commitment = Commitment.find(params[:id])
		puts params
	end

	def index
		@commitments = Commitment.all
		puts params
	end

end
