class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	# VALIDATIONS
  validates :username, 
  uniqueness: { message: ": Ce nom d'utilisateur existe déjà" }

  validates :first_name, 
  length: {minimum: 1, maximum: 20},
  allow_blank: true 

  validates :last_name, 
  length: {minimum: 1, maximum: 50},
  allow_blank: true

  has_many :posts
  has_many :replies 
  
  # LINK TABLES
	#	LINK COMMITMENTS
  has_many :user_commitments, dependent: :destroy
  has_many :commitments, through: :user_commitments
	# LINK THEMES
	has_many :user_themes, dependent: :destroy
	has_many :themes, through: :user_themes
	# CALLBACKS
  after_create :assign_default_username
  after_create :welcome_send

	# METHODS

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def assign_default_username
    self.username = "Utilisateur#{self.id}"
    self.save
  end

  def display
    if self.name_display == true
      return "#{self.first_name}  #{self.last_name}"
    else
      return self.username
    end
  end

	def self.count_by_day
    hash = Hash.new

		# SORTING USERS BY CREATION DATE TO AN ARRAY
		sorted_array = self.all.sort { |a, b| a.created_at <=> b.created_at }
		sorted_array.each do |each_user|
			if hash[each_user.created_at.to_date] == nil
				hash[each_user.created_at.to_date] = 0
			end
			hash[each_user.created_at.to_date] += 1
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
