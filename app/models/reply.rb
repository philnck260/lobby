class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content,
  presence: {message: ': Le contenu est requis'},
  length: {maximum: 500, message: ": Le contenu ne doit pas dépasser 500 caractères"}

	# METHODS
	def current_user_is_author?
		if user_signed_in? && self.user == current_user
			return true
		end
		return false
	end

end
