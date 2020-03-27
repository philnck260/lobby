class Source < ApplicationRecord
	
	# LINK
	belongs_to :sourceable, polymorphic: true	 

	# VALIDATIONS
	validates :title, presence: true, length: {minimum: 10, maximum: 50}
	validates :description, presence: true, length: {minimum: 75, maximum: 150}
	validates :url, presence: true
	validates :category, presence: true
	validates :media, presence: true

	# METHODS

end
