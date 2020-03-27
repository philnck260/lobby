class Theme < ApplicationRecord

	# VALIDATIONS
	validates :title, presence: true
	validates :description, presence: true
	validates :sources, presence: true

	# LINK TABLES
	# LINK USERS
	has_many :user_themes, dependent: :destroy
	has_many :users, through: :user_themes
	# LINK COMMITMENTS
	has_many :commitment_themes, dependent: :destroy
	has_many :commitments, through: :commitment_themes
	# LINK SOURCES
	has_many :sources, as: :sourceable, dependent: :destroy
	accepts_nested_attributes_for :sources, allow_destroy: true, reject_if: proc { |s_attr| s_attr[:url].blank? }

	# METHODS

	# METHOD FOR LINE_CHART IN THEME#SHOW VIEW
	def users_by_day
		hash = Hash.new
		# SORTING USER_COMMITMENTS BY CREATION DATE TO AN ARRAY
		sorted_array = self.user_themes.all.sort { |a, b| a.created_at <=> b.created_at }
		# CREATING A HASH WHERE EACH DATE FROM FIRST UC CONTAINS VALUE OF UCs CREATED
		sorted_array.each do |each_ut|
			if hash[each_ut.created_at.to_date] == nil
				hash[each_ut.created_at.to_date] = 0
			end
			hash[each_ut.created_at.to_date] += 1
		end
		day_count = sorted_array[0].created_at.to_date
		hash[day_count - 1.days] = 0
		# INCREMENTING WITH PREVIOUS DAY
		while (day_count <= Date.today)
			if hash[day_count] != nil
				hash[day_count] = hash[day_count - 1.days] + hash[day_count]
			else
				hash[day_count] = hash[day_count - 1.days]
			end
			day_count += 1.days
		end
		return hash
	end

end
