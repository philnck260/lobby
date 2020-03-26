class Post < ApplicationRecord

	validates :title, 
		presence: {message: ': Un titre de post est requis'},
		length: {minimum: 5, maximum: 50, message: ': Le titre doit contenir un minimum de 5 et un maximum de 50 caractères'}

	validates :content,
		presence: {message: ': Un contenu de post est requis'},
		length: {minimum: 5, maximum: 500,  message: ': Le titre doit contenir un minimum de 5 et un maximum de 500 caractères'}

	belongs_to :user
	has_many :replies
	belongs_to :forum 

	# METHODS

	def sorted_replies
		sort_array = Array.new
		sort_array = self.replies.sort { |a, b| a.created_at <=> b.created_at }
	end

	def last_reply
		sort_array = Array.new
		sort_array = self.replies.sort { |a, b| b.created_at <=> a.created_at }
		return sort_array[0]
	end

	def current_user_is_author?
		if user_signed_in? && self.user == current_user
			return true
		end
		return false
	end

end

