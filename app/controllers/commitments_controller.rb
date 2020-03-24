class CommitmentsController < ApplicationController

	before_action :store_location

	def show
		@commitment = Commitment.find(params[:id])
		puts params
	end

	def index
		@commitments = Commitment.all
		puts params
	end

end
