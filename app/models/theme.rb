class Theme < ApplicationRecord
	
	# VALIDATIONS
	validates :title, presence: true
	validates :description, presence: true

	# LINK TABLES
	# LINK USERS
	has_many :user_themes, dependent: :destroy
	has_many :users, through: :user_themes
	# LINK COMMITMENTS
	has_many :commitment_themes, dependent: :destroy
	has_many :commitments, through: :commitment_themes

end
