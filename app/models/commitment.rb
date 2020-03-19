class Commitment < ApplicationRecord

	# VALIDATIONS
	validates :title, presence: {message: ": Le titre est obligatoire"}, length: {minimum: 10, message: ": Le titre doit avoir 10 caractères minimum"}
	validates :description, presence: {message: ": La description est obligatoire"}, length: {minimum: 20, message: ": La description doit avoir 20 caractères minimum"}

	# LINK TABLES
	has_many :user_commitments, dependent: :destroy
	has_many :users, through: :user_commitments
	
	# METHODS
	def self.users_number
		hash = Hash.new
		self.all.each do |each_commitment|
			hash[each_commitment.title] = each_commitment.users.count
		end	
		return hash
	end

end
