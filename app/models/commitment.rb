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

	# METHOD TO RETURN ARRAY OF TWO MOST POPULAR COMMITMENTS IN HOMEPAGE
	def self.by_popularity 
		to_sort_array = Commitment.all
		to_sort_array.sort { |a, b| b.users.count <=> a.users.count }
	end	

	# METHOD TO CREATE A FORUM AFTER A CREATION OF COMMITMENT
	def create_forum
    @forum = Forum.create(id: self.id, commitment: self)
  end

end
