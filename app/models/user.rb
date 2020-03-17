class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_username

  def assign_default_username
    self.username = "User#{self.id}"
    self.save
  end

	# LINK TABLES
	has_many :user_commitments, dependent: :destroy
	has_many :commitments, through: :user_commitments

end
