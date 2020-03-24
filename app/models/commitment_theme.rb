class CommitmentTheme < ApplicationRecord

	# LINK AS JOIN TABLE
	belongs_to :commitment
	belongs_to :theme

end
