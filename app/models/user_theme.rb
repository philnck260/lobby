class UserTheme < ApplicationRecord

	# LINK AS JOIN TABLE
	belongs_to :user
	belongs_to :theme

	validates_uniqueness_of :theme, :scope => :user, :message => "Vous suivez déjà ce Thème."

end
