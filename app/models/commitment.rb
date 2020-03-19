class Commitment < ApplicationRecord

	# VALIDATIONS
	validates :title, presence: true, length: {minimum: 10}
	validates :description, presence: true, length: {minimum: 20}

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
