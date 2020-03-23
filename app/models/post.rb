class Post < ApplicationRecord
  
  validates :title, 
  length: {minimum: 5, maximum: 50},
  allow_blank: true

  validates :content, 
  length: {minimum: 5, maximum: 500},
  allow_blank: true 

  belongs_to :user
end

