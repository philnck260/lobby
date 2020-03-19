class UserCommitment < ApplicationRecord
  belongs_to :user
  belongs_to :commitment

  validates_uniqueness_of :commitment, :scope => :user, :message => "vous êtes déjà incrit à ce mouvement"
  
end
