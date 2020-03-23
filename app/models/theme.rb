class Theme < ApplicationRecord

	# VALIDATIONS
	validates :title, presence: true
	validates :description, presence: true

	# LINK TABLES
	# LINK USERS
	has_many :user_themes, dependent: :destroy
	has_many :users, through: :user_themes
	# LINK COMMITMENTS
	has_many :commitment_themes, dependent: :destroy
	has_many :commitments, through: :commitment_themes

	# METHODS
	# METHOD FOR PIE_CHART IN STATIC#STATISTICS VIEW
	# RETRIEVE FROM COMMITMENT_MODEL

	# METHOD FOR LINE_CHART IN THEME#SHOW VIEW
	def users_by_day
		hash = Hash.new
		self.users.each do |each_user|
			date = each_user.created_at.to_date
			if hash[date] == nil
				if hash[date - 1.day] == nil
					hash[date - 1.day] = 0
				end
				hash[date] = hash[date - 1.day]
			end
			hash[date] += 1
		end
		return hash
	end

end
