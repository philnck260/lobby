class UserTheme < ApplicationRecord

	# LINK AS JOIN TABLE
	belongs_to :user
	belongs_to :theme

end
