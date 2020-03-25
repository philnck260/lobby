class Source < ApplicationRecord
	# CALLBACKS
	
	
	# LINK
	belongs_to :sourceable, polymorphic: true	 

	# VALIDATIONS
	validates :title, presence: true
	validates :description, presence: true
	validates :url, presence: true
	validates :category, presence: true
	validates :media, presence: true

	# METHODS
	

end
