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
  
	# CALLBACKS
  after_create :assign_default_username
  after_create :welcome_send

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

  # LINK TABLES
	#	LINK COMMITMENTS
  has_many :user_commitments, dependent: :destroy
  has_many :commitments, through: :user_commitments
	# LINK THEMES
	has_many :user_themes, dependent: :destroy
	has_many :themes, through: :user_themes

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
