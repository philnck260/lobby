class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :validatable

	after_create :assign_default_username

	after_create :welcome_send

	def welcome_send
		UserMailer.welcome_email(self).deliver_now
	end

	def assign_default_username
		self.username = "User#{self.id}"
		self.save
	end

	def display
		if self.name_display == true
			return "#{self.first_name}  #{self.last_name}"
		else
			return self.username
		end
	end

	# LINK TABLES
	has_many :user_commitments, dependent: :destroy
	has_many :commitments, through: :user_commitments

	@@first_user = self.first
=begin
	def self.count_by_day
		today = Date.today
		beginning = @@first_user.created_at.to_date
		total = 0
		hash = Hash.new
		while (beginning <= today + 1.day)
			total += self.where(created_at: beginning).count
			beginning += 1.day
			puts total
			hash[beginning] = total
		end
		return hash 
	end
=end
	def self.count_by_day
		hash = Hash.new
		self.all.each do |each_user|
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
