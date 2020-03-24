class CommitmentTheme < ApplicationRecord

	# LINK AS JOIN TABLE
	belongs_to :commitment
	belongs_to :theme

	accepts_nested_attributes_for :theme

end
