module Admin
  class CommitmentsController < ApplicationController
    before_action :find_commitment, only: [:edit, :update, :destroy]

    def index
      @commitments = Commitment.all
    end

    def new
      @commitment = Commitment.new
    end

    def create
        @commitment = Commitment.new(commitment_params)
      if @commitment.save
        flash[:sucess] = "Vous avez créé un mouvement"
        redirect_to admin_commitments_path
      else
        flash[:warning] = "Vous n'avez pas réussi à créer un mouvement : le titre et la description doivent avoir respectivement 10 et 20 caractères"
        redirect_to new_admin_commitment_path
      end
    end

    def edit
    end

    def update
      @commitment.update(commitment_params)
      redirect_to admin_commitments_path
    end

    def destroy
      @commitment.destroy
      redirect_to admin_commitments_path
    end

    private

    def find_commitment
      @commitment = Commitment.find(params[:id])
    end

    def commitment_params
      params.require(:commitment).permit(:title, :description)
    end
  end
end
