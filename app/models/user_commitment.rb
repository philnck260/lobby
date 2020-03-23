class UserCommitment < ApplicationRecord
  belongs_to :user
  belongs_to :commitment

	validates_uniqueness_of :commitment, :scope => :user, :message => "Vous avez déjà rejoint ce Mouvement."
  
end
