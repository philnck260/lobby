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

end
