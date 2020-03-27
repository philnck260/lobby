class Commitment < ApplicationRecord

	# CALLBACKS
	after_create :create_forum

	# VALIDATIONS
	validates :title, presence: {message: ": Le titre est obligatoire"}, length: {minimum: 10, message: ": Le titre doit avoir 10 caractères minimum"}
	validates :description, presence: {message: ": La description est obligatoire"}, length: {minimum: 20, message: ": La description doit avoir 20 caractères minimum"}
	validates :commitment_themes, presence: true
	validates :sources, presence: true

	# LINK TABLES
	# LINK USERS
	has_many :user_commitments, dependent: :destroy
	has_many :users, through: :user_commitments
	# LINK THEMES
	has_many :commitment_themes, dependent: :destroy
	has_many :themes, through: :commitment_themes
	accepts_nested_attributes_for :commitment_themes, allow_destroy: true, reject_if: proc { |ct_attr| ct_attr[:theme_id].blank? }
	# LINK FORUMS
	has_one :forum, dependent: :destroy
	# LINK SOURCES
	has_many :sources, as: :sourceable, dependent: :destroy
	accepts_nested_attributes_for :sources, allow_destroy: true, reject_if: proc { |s_attr| s_attr[:url].blank? }

	# METHODS
	# METHOD FOR PIE_CHART IN STATIC#STATISTICS VIEW
	def self.users_number
		hash = Hash.new
		self.all.each do |each_commitment|
			hash[each_commitment.title] = each_commitment.users.count
		end	
		return hash
	end

	# METHOD FOR LINE_CHART IN COMMITMENT#SHOW VIEW
	def users_by_day
		hash = Hash.new
		# SORTING USER_COMMITMENTS BY CREATION DATE TO AN ARRAY
		sorted_array = self.user_commitments.all.sort { |a, b| a.created_at <=> b.created_at }
		# CREATING A HASH WHERE EACH DATE FROM FIRST UC CONTAINS VALUE OF UCs CREATED
		sorted_array.each do |each_uc|
			if hash[each_uc.created_at.to_date] == nil
				hash[each_uc.created_at.to_date] = 0
			end
			hash[each_uc.created_at.to_date] += 1
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

	# METHOD TO RETURN ARRAY OF COMMITMENTS SORTED BY USERS_NUMBER, TO HOMEPAGE
	def self.by_popularity 
		to_sort_array = Commitment.all
		to_sort_array.sort { |a, b| b.users.count <=> a.users.count }
	end	

	# METHOD TO CREATE A FORUM AFTER A CREATION OF COMMITMENT
	def create_forum
		@forum = Forum.create(id: self.id, commitment: self)
	end

end
